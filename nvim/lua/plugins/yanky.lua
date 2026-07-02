-- yank history
local M = {}
local HISTORY_KEY = "YANKY_HISTORY"
local MAX_HISTORY = 100

local function get_history()
  return vim.g[HISTORY_KEY] or {}
end

local function set_history(h)
  vim.g[HISTORY_KEY] = h
end

local function push(regcontents, regtype)
  if not regcontents or regcontents == "" then
    return
  end
  local h = vim.deepcopy(get_history())
  if h[1] and h[1].regcontents == regcontents and h[1].regtype == regtype then
    return
  end
  table.insert(h, 1, { regcontents = regcontents, regtype = regtype })
  if #h > MAX_HISTORY then
    h[MAX_HISTORY + 1] = nil
  end
  set_history(h)
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHistory", { clear = true }),
  callback = function()
    local event = vim.v.event
    if event.operator == "y" or event.regname == "+" or event.regname == "*" then
      local reg = event.regname ~= "" and event.regname or '"'
      push(vim.fn.getreg(reg), vim.fn.getregtype(reg))
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

local function fallback_pick(history)
  local labels = {}
  for i, entry in ipairs(history) do
    labels[i] = ("[%d] %s"):format(i, vim.split(entry.regcontents or "", "\n")[1] or "")
  end

  vim.ui.select(labels, { prompt = "Yank History" }, function(choice)
    if not choice then
      return
    end
    local idx = tonumber(choice:match("%[(%d+)%]"))
    local entry = history[idx]
    vim.fn.setreg('"', entry.regcontents, entry.regtype)
    if vim.tbl_contains(vim.opt.clipboard:get(), "unnamedplus") then
      vim.fn.setreg("+", entry.regcontents, entry.regtype)
    end
    vim.schedule(function()
      vim.cmd("normal! p")
    end)
  end)
end

function M.pick()
  local history = get_history()
  if #history == 0 then
    vim.notify("Yank history is empty", vim.log.levels.INFO)
    return
  end

  local ok, snacks = pcall(require, "snacks")
  if ok and snacks.picker then
    local items = {}
    for i, entry in ipairs(history) do
      local text = entry.regcontents or ""
      local first_line = vim.split(text, "\n")[1] or ""
      local regtype = entry.regtype or "v"
      local type_label = regtype == "V" and "line" or regtype == "\22" and "block" or "char"
      items[i] = {
        text = first_line,
        idx = i,
        regcontents = text,
        regtype = regtype,
        type_label = type_label,
        preview = { text = text },
      }
    end

    snacks.picker({
      title = " Yank History",
      items = items,
      preview = "preview",
      format = function(item, _)
        local badge = ("[%d]"):format(item.idx)
        return {
          { badge .. " ", "Constant" },
          { item.text, "Normal" },
          { (" (%s)"):format(item.type_label), "Special" },
        }
      end,
      confirm = function(picker, item)
        picker:close()
        if not item then
          return
        end
        vim.fn.setreg('"', item.regcontents, item.regtype)
        local cb = vim.opt.clipboard:get()
        if vim.tbl_contains(cb, "unnamedplus") then
          vim.fn.setreg("+", item.regcontents, item.regtype)
        end
        vim.schedule(function()
          vim.cmd("normal! p")
        end)
      end,
    })
  else
    fallback_pick(history)
  end
end

vim.keymap.set({ "n", "x" }, "<leader>y", M.pick, { desc = "Yank history" })

return M
