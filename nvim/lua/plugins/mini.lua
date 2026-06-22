vim.pack.add({
  "https://github.com/echasnovski/mini.nvim",
})

-- mini.pairs: lazy on first InsertEnter
local _pairs_loaded = false
vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    if _pairs_loaded then
      return
    end
    _pairs_loaded = true
    require("mini.pairs").setup()
  end,
})

-- mini.surround: lazy via stub keymaps (default `s` prefix)
local _surround_loaded = false
local surround_keys = { "sa", "sd", "sf", "sF", "sh", "sr", "sn" }

local function load_surround()
  if _surround_loaded then
    return
  end
  _surround_loaded = true
  for _, k in ipairs(surround_keys) do
    pcall(vim.keymap.del, "n", k)
    pcall(vim.keymap.del, "x", k)
  end
  require("mini.surround").setup()
end

for _, k in ipairs(surround_keys) do
  vim.keymap.set({ "n", "x" }, k, function()
    load_surround()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(k, true, false, true), "m", false)
  end, { desc = "Surround (lazy)" })
end

-- mini.files: lazy on first <leader>E. Coexists with Snacks.explorer (<leader>e).
local _files_loaded = false

local function map_split(buf_id, lhs, direction)
  local minifiles = require("mini.files")

  local function rhs()
    local window = minifiles.get_explorer_state().target_window

    -- Noop if the explorer isn't open or the cursor is on a directory.
    if window == nil or minifiles.get_fs_entry().fs_type == "directory" then
      return
    end

    -- Make a new window and set it as target.
    local new_target_window
    vim.api.nvim_win_call(window, function()
      vim.cmd(direction .. " split")
      new_target_window = vim.api.nvim_get_current_win()
    end)

    minifiles.set_target_window(new_target_window)

    -- Go in and close the explorer.
    minifiles.go_in({ close_on_file = true })
  end

  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. string.sub(direction, 12) })
end

local function setup_files()
  if _files_loaded then
    return
  end
  _files_loaded = true

  local minifiles = require("mini.files")

  minifiles.setup({
    mappings = {
      show_help = "?",
      go_in_plus = "<cr>",
      go_out_plus = "<tab>",
    },
    content = {
      filter = function(entry)
        return entry.fs_type ~= "file" or entry.name ~= ".DS_Store"
      end,
      sort = function(entries)
        local function compare_alphanumerically(e1, e2)
          -- Put directories first.
          if e1.is_dir and not e2.is_dir then
            return true
          end
          if not e1.is_dir and e2.is_dir then
            return false
          end
          -- Order numerically based on digits if the text before them is equal.
          if e1.pre_digits == e2.pre_digits and e1.digits ~= nil and e2.digits ~= nil then
            return e1.digits < e2.digits
          end
          -- Otherwise order alphabetically ignoring case.
          return e1.lower_name < e2.lower_name
        end

        local sorted = vim.tbl_map(function(entry)
          local pre_digits, digits = entry.name:match("^(%D*)(%d+)")
          if digits ~= nil then
            digits = tonumber(digits)
          end

          return {
            fs_type = entry.fs_type,
            name = entry.name,
            path = entry.path,
            lower_name = entry.name:lower(),
            is_dir = entry.fs_type == "directory",
            pre_digits = pre_digits,
            digits = digits,
          }
        end, entries)
        table.sort(sorted, compare_alphanumerically)
        return vim.tbl_map(function(x)
          return { name = x.name, fs_type = x.fs_type, path = x.path }
        end, sorted)
      end,
    },
    windows = { width_nofocus = 25 },
    options = { permanent_delete = false },
  })

  local group = vim.api.nvim_create_augroup("user_minifiles", { clear = true })

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "MiniFilesExplorerOpen",
    callback = function()
      vim.g.minifiles_active = true
    end,
  })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "MiniFilesExplorerClose",
    callback = function()
      vim.g.minifiles_active = false
    end,
  })

  -- Notify LSPs that a file got renamed or moved (borrowed from snacks.nvim).
  vim.api.nvim_create_autocmd("User", {
    group = group,
    desc = "Notify LSPs that a file was renamed",
    pattern = { "MiniFilesActionRename", "MiniFilesActionMove" },
    callback = function(args)
      local changes = {
        files = {
          {
            oldUri = vim.uri_from_fname(args.data.from),
            newUri = vim.uri_from_fname(args.data.to),
          },
        },
      }
      local will_rename_method, did_rename_method = "workspace/willRenameFiles", "workspace/didRenameFiles"
      local clients = vim.lsp.get_clients()
      for _, client in ipairs(clients) do
        if client:supports_method(will_rename_method) then
          local res = client:request_sync(will_rename_method, changes, 1000, 0)
          if res and res.result then
            vim.lsp.util.apply_workspace_edit(res.result, client.offset_encoding)
          end
        end
      end

      for _, client in ipairs(clients) do
        if client:supports_method(did_rename_method) then
          client:notify(did_rename_method, changes)
        end
      end
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    group = group,
    desc = "Add minifiles split keymaps",
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
      local buf_id = args.data.buf_id
      map_split(buf_id, "<C-w>s", "belowright horizontal")
      map_split(buf_id, "<C-w>v", "belowright vertical")
    end,
  })
end

vim.keymap.set("n", "<leader>E", function()
  setup_files()
  local minifiles = require("mini.files")
  local bufname = vim.api.nvim_buf_get_name(0)
  local path = vim.fn.fnamemodify(bufname, ":p")

  -- Open at the current file when it exists on disk, else at cwd.
  if path ~= "" and vim.uv.fs_stat(path) then
    minifiles.open(bufname, false)
  else
    minifiles.open(vim.uv.cwd(), false)
  end
end, { desc = "File explorer (mini.files)" })
