-- Editor: Navigation, text objects, pairs, statusline, and utilities

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

return {
  --{
  --  "folke/flash.nvim",
  --  event = "VeryLazy",
  --  ---@type Flash.Config
  --  opts = {},
  --  -- stylua: ignore
  --  keys = {
  --    { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
  --    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
  --    { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
  --    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --    { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  --  },
  --},

  {
    "echasnovski/mini.nvim",
    --keys = {
    --  {
    --    "<leader>cj",
    --    function()
    --      require("mini.splitjoin").toggle()
    --    end,
    --    desc = "Join/split code block",
    --  },
    --},
    config = function()
      -- Better Around/Inside textobjects
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      require("mini.pairs").setup()

      local statusline = require("mini.statusline")
      statusline.setup({
        use_icons = vim.g.have_nerd_font,
        set_vim_settings = false,
      })
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },

  {
    "echasnovski/mini.icons",
    enabled = true,
    opts = {},
    lazy = true,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },

  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- Global keymaps that will lazy-load obsidian.nvim on first use
    keys = {
      { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian Quick Switch" },
      { "<leader>og", "<cmd>Obsidian search<cr>", desc = "Obsidian Search" },
      { "<leader>ot", "<cmd>Obsidian today<cr>", desc = "Obsidian Today" },
      { "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Obsidian Yesterday" },
      { "<leader>on", "<cmd>Obsidian new<cr>", desc = "Obsidian New Note" },
      { "<leader>ol", "<cmd>Obsidian follow_link<cr>", desc = "Obsidian Follow Link" },
      { "<leader>oL", "<cmd>Obsidian link_new<cr>", desc = "Obsidian Link New" },
    },

    config = function()
      require("obsidian").setup({
        legacy_commands = false,
        ui = { enable = false },
        workspaces = {
          {
            name = "bzasc-brain",
            path = vim.env.OBSIDIAN_VAULT or "~/annotations/bzasc_brain",
          },
        },
        notes_subdir = "inbox",
        new_notes_location = "notes_subdir",

        templates = {
          subdir = "templates",
          date_format = "%Y-%m-%d",
          time_format = "%H:%M:%S",
        },

        daily_notes = {
          folder = "periodic-notes/dailies",
          date_format = "YYYY-MM/YYYY-MM-DD",
          default_tags = { "daily-notes" },
          template = "templates/daily.md",
        },

        completion = {
          blink = true,
          min_chars = 2,
        },
      })
    end,
  },

  { "b0o/SchemaStore.nvim", lazy = true },

  {
    "echasnovski/mini.files",
    keys = {
      {
        "<leader>e",
        function()
          local bufname = vim.api.nvim_buf_get_name(0)
          local path = vim.fn.fnamemodify(bufname, ":p")

          -- Noop if the buffer isn't valid.
          if path and vim.uv.fs_stat(path) then
            require("mini.files").open(bufname, false)
          end
        end,
        desc = "File explorer",
      },
    },
    opts = {
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
    },
    config = function(_, opts)
      local minifiles = require("mini.files")

      minifiles.setup(opts)

      local minifiles_explorer_group = vim.api.nvim_create_augroup("bzasc/minifiles_explorer", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = minifiles_explorer_group,
        pattern = "MiniFilesExplorerOpen",
        callback = function()
          vim.g.minifiles_active = true
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        group = minifiles_explorer_group,
        pattern = "MiniFilesExplorerClose",
        callback = function()
          vim.g.minifiles_active = false
        end,
      })

      -- HACK: Notify LSPs that a file got renamed or moved.
      -- Borrowed this from snacks.nvim.
      vim.api.nvim_create_autocmd("User", {
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
        desc = "Add minifiles split keymaps",
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          map_split(buf_id, "<C-w>s", "belowright horizontal")
          map_split(buf_id, "<C-w>v", "belowright vertical")
        end,
      })
    end,
  },
  {
    "gbprod/yanky.nvim",
    opts = {
      ring = { history_length = 20 },
      highlight = { timer = 250 },
    },
    keys = {
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
      { "=p", "<Plug>(YankyPutAfterLinewise)", desc = "Put yanked text in line below" },
      { "=P", "<Plug>(YankyPutBeforeLinewise)", desc = "Put yanked text in line above" },
      { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
      { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yanky yank" },
    },
  },
}
