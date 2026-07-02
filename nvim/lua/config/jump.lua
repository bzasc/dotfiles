local NS = vim.api.nvim_create_namespace("jump")
local LABELS = vim.fn.split("fdsaghjklrewqtyuiopvcxzbnmFDSAGHJKLREWQTYUIOPVCXZBNM0123456789;,.-='", "\\zs")

local function jump()
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_win_get_buf(win)
  local info = vim.fn.getwininfo(win)[1]
  local top = info.topline
  local lines = vim.api.nvim_buf_get_lines(buf, top - 1, info.botline, true)

  local ch = vim.fn.getcharstr()
  if ch == "\27" then
    return
  end

  local pat = ch:lower()
  local targets, li = {}, 1

  for idx, line in ipairs(lines) do
    local lnum = top + idx - 1
    local row = lnum - 1
    local col = 1
    local haystack = line:lower()
    while true do
      local s, e = haystack:find(pat, col, true)
      if not s then
        break
      end
      vim.api.nvim_buf_set_extmark(buf, NS, row, s - 1, {
        end_col = e,
        hl_group = "Search",
        priority = 200,
      })
      local label = LABELS[li]
      if label then
        targets[label] = { lnum, s - 1 }
        vim.api.nvim_buf_set_extmark(buf, NS, row, s - 1, {
          virt_text = { { label, "IncSearch" } },
          virt_text_pos = "overlay",
          priority = 201,
        })
        li = li + 1
      end
      col = e + 1
    end
  end

  vim.cmd.redraw()
  local label = vim.fn.getcharstr()
  vim.api.nvim_buf_clear_namespace(buf, NS, 0, -1)
  vim.cmd.redraw()
  if targets[label] then
    vim.cmd("normal! m'")
    vim.api.nvim_win_set_cursor(win, targets[label])
  end
end

for _, key in ipairs({ "s", "f", "t" }) do
  vim.keymap.set({ "n", "x", "o" }, key, jump, { desc = "Jump" })
end
