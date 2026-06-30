local M = {}

local SEP = "" -- separator glyph at buffer boundary
local CLOSE = "" -- close icon shown on active buffer
local NO_NAME = "[NO NAME]"
local OVERFLOW_LEFT = "«"
local OVERFLOW_RIGHT = "»"

local _tab_cache = nil -- cached rendered string
local _tab_cache_key = nil -- cache key: bufnr + columns + buffer-list signature

local _tab_invalidate_events = {
  "BufAdd",
  "BufDelete",
  "BufWipeout",
  "BufFilePost", -- buffer renamed
  "BufWritePost", -- save clears the modified flag
  "TextChanged", -- normal-mode edit sets modified flag
  "TextChangedI", -- insert-mode edit sets modified flag
  "VimResized", -- terminal resize changes layout
  "TabEnter", -- tabpage switch may change active buffer set
}

vim.api.nvim_create_autocmd(_tab_invalidate_events, {
  group = vim.api.nvim_create_augroup("MyTablineCache", { clear = true }),
  callback = function()
    _tab_cache = nil
  end,
})

function M.set_highlights()
  vim.api.nvim_set_hl(0, "MyBufInactive", { fg = "#ABB2BF", bg = "#282C34" })
  vim.api.nvim_set_hl(0, "MyBufActive", { fg = "#ECEFF4", bg = "#3E4451", bold = true })
  vim.api.nvim_set_hl(0, "MyBufSeparator", { fg = "#21252B", bg = "#282C34" })
  vim.api.nvim_set_hl(0, "MyBufClose", { fg = "#BF616A", bg = "#3E4451" })
end

-- Safe devicons resolve (cached per render)
local function get_icon(filename, name)
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok or not name or name == "" then
    return ""
  end
  local ext = vim.fn.fnamemodify(name, ":e")
  local icon = devicons.get_icon(filename, ext, { default = true })
  return icon and (icon .. " ") or ""
end

-- Extract parent folders + filename (e.g., "parent/config/tabline.lua")
local function get_display_name(path)
  if path == "" then
    return NO_NAME
  end
  local parts = vim.split(path, "/", { plain = true })
  if #parts == 1 then
    return parts[1] -- Just filename if no parent
  elseif #parts == 2 then
    return parts[#parts - 1] .. "/" .. parts[#parts] -- parent/filename
  else
    -- Return "grandparent/parent/filename" (last 3 parts)
    return parts[#parts - 2] .. "/" .. parts[#parts - 1] .. "/" .. parts[#parts]
  end
end

-- Render a single buffer chunk
local function render_buf(bufnr, current)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    return ""
  end
  if not vim.bo[bufnr].buflisted then
    return ""
  end

  local name = vim.api.nvim_buf_get_name(bufnr)
  local display_name = get_display_name(name)
  local filename = (name ~= "" and vim.fn.fnamemodify(name, ":t")) or NO_NAME
  local icon = get_icon(filename, name)
  local content = icon .. display_name

  if bufnr == current then
    return table.concat({
      "%#MyBufActive# ",
      content,
      " %#MyBufClose#",
      CLOSE,
      " %#MyBufSeparator#",
      SEP,
    })
  else
    return table.concat({
      "%#MyBufInactive# ",
      content,
      "  %#MyBufSeparator#",
      SEP,
    })
  end
end

-- Strip statusline highlight groups (%#...#) to measure real display width
local function display_width(s)
  local stripped = s:gsub("%%#[^#]*#", ""):gsub("%%%%", "%%")
  return vim.api.nvim_strwidth(stripped)
end

function _G.tabline()
  local current = vim.api.nvim_get_current_buf()
  local columns = vim.o.columns

  -- Render every listed buffer; remember which index is the active one.
  -- We must build chunks before the cache check, because the cache key
  -- includes the buffer-list signature.
  local chunks = {}
  local active_idx = nil
  local sig = {} -- signature pieces for the cache key
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local chunk = render_buf(bufnr, current)
    if chunk ~= "" then
      table.insert(chunks, chunk)
      sig[#sig + 1] = bufnr .. ":" .. (vim.bo[bufnr].modified and "1" or "0")
      if bufnr == current then
        active_idx = #chunks
      end
    end
  end

  local key = current .. "|" .. columns .. "|" .. table.concat(sig, ",")
  if _tab_cache and _tab_cache_key == key then
    return _tab_cache
  end

  if #chunks == 0 then
    _tab_cache = ""
    _tab_cache_key = key
    return ""
  end

  local widths = {}
  local total = 0
  for i, c in ipairs(chunks) do
    widths[i] = display_width(c)
    total = total + widths[i]
  end

  -- Fast path: everything fits
  if total <= columns then
    local line = table.concat(chunks):gsub(vim.pesc(SEP) .. "$", "")
    _tab_cache = line
    _tab_cache_key = key
    return line
  end

  -- Sliding window: keep the active buffer visible, then expand outward
  -- (alternating sides) until we run out of room. Reserve space for
  -- overflow markers only on sides where buffers are actually hidden.
  -- Markers include a count, like " 3 « ... » 5 ".
  active_idx = active_idx or 1

  local function marker_width(count, glyph)
    -- e.g. " 12 « " = 6, " » 3 " = 5
    return count > 0 and (vim.api.nvim_strwidth(glyph) + #tostring(count) + 3) or 0
  end

  local first, last = active_idx, active_idx
  local used = widths[active_idx]

  while true do
    local left_count = first - 1
    local right_count = #chunks - last
    local reserved = marker_width(left_count, OVERFLOW_LEFT) + marker_width(right_count, OVERFLOW_RIGHT)
    local budget = columns - reserved

    local grew = false
    -- Alternate: prefer extending right (more natural reading order)
    if last < #chunks and used + widths[last + 1] <= budget then
      last = last + 1
      used = used + widths[last]
      grew = true
    elseif first > 1 and used + widths[first - 1] <= budget then
      first = first - 1
      used = used + widths[first]
      grew = true
    end
    if not grew then
      break
    end
  end

  local visible = {}
  local left_count = first - 1
  local right_count = #chunks - last
  if left_count > 0 then
    table.insert(visible, "%#MyBufInactive# " .. left_count .. " " .. OVERFLOW_LEFT .. " ")
  end
  for i = first, last do
    table.insert(visible, chunks[i])
  end
  if right_count > 0 then
    table.insert(visible, "%#MyBufInactive# " .. OVERFLOW_RIGHT .. " " .. right_count .. " ")
  end

  local line = table.concat(visible):gsub(vim.pesc(SEP) .. "$", "")
  _tab_cache = line
  _tab_cache_key = key
  return line
end

function M.setup()
  M.set_highlights()

  vim.api.nvim_create_augroup("MyTabline", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = "MyTabline",
    callback = M.set_highlights,
  })

  vim.opt.showtabline = 2
  vim.opt.tabline = "%!v:lua.tabline()"
end

-- Close all buffers to the left/right of the current one
vim.keymap.set("n", "<leader>bl", function()
  local cur = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and buf < cur then
      pcall(vim.api.nvim_buf_delete, buf, { force = true })
    end
  end
end, { desc = "Close all left buffers" })

vim.keymap.set("n", "<leader>br", function()
  local cur = vim.api.nvim_get_current_buf()
  local bufs = vim.api.nvim_list_bufs()
  for i = #bufs, 1, -1 do
    local buf = bufs[i]
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and buf > cur then
      pcall(vim.api.nvim_buf_delete, buf, { force = true })
    end
  end
end, { desc = "Close all right buffers" })

M.setup()

return M
