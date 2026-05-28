vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim",
})

local palette = {
  burgundy = "#5f2d3b",
  charcoal_gray = "#2c2f33",
  dark_cyan = "#2a303c",
  dark_gray = "#1d2021",
  dark_sienna = "#4a2e2a",
  deep_teal = "#2e4954",
  forest_mist = "#35403b",
  green = "#89b482",
  light_gray = "#ebdbb2",
  light_green = "#a9b665",
  midnight_blue = "#1e2630",
  moss_green = "#3e4a33",
  pink = "#d3869b",
  red = "#ea6962",
  sky_blue = "#7daea3",
  slate_blue = "#3b4261",
  smoky_orchid = "#574b65",
  soft_violet = "#4c4567",
  teal = "#458588",
  yellow = "#d8a657",
}

local mode_color = { bg = palette.green, fg = palette.dark_gray, gui = "bold" }
local git_color = { bg = palette.dark_sienna, fg = palette.light_gray, gui = "bold" }
local buffer_color = { bg = palette.dark_cyan, fg = palette.light_gray }
local location_color = { bg = palette.soft_violet, fg = palette.light_gray }
local percent_color = { bg = palette.teal, fg = palette.dark_gray, gui = "bold" }
local none_color = { bg = "NONE", fg = palette.light_gray }

local theme = {
  normal = {
    a = mode_color,
    b = git_color,
    c = none_color,
    x = none_color,
    y = buffer_color,
    z = percent_color,
  },
  insert = { a = mode_color },
  visual = { a = mode_color },
  replace = { a = mode_color },
  command = { a = mode_color },
  terminal = { a = mode_color },
  inactive = {
    a = none_color,
    b = none_color,
    c = none_color,
  },
}

local _repo_cache = {}

local function git_repo_branch()
  local branch = vim.b.gitsigns_head
  if not branch or branch == "" then
    return ""
  end
  local gs = vim.b.gitsigns_status_dict
  if gs and gs.root then
    local repo = _repo_cache[gs.root]
    if not repo then
      repo = vim.fn.fnamemodify(gs.root, ":t")
      _repo_cache[gs.root] = repo
    end
    return " " .. repo .. "/" .. branch
  end
  return " " .. branch
end

local _wc = { words = 0 }

vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
  callback = function()
    local ft = vim.bo.filetype
    if ft:match("md") or ft:match("markdown") or ft == "text" then
      vim.defer_fn(function()
        _wc.words = vim.fn.wordcount().words or 0
      end, 500)
    else
      _wc.words = 0
    end
  end,
})

local function word_reading()
  local w = _wc.words
  if w == 0 then
    return ""
  end
  return " " .. w .. "w  " .. math.ceil(w / 200) .. "m"
end

local function lsp_progress()
  return vim.ui.progress_status and vim.ui.progress_status() or ""
end

local _rec = ""

local function macro_recording()
  return _rec
end

vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.showcmdloc = "statusline"

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    _rec = " REC @" .. vim.fn.reg_recording()
    require("lualine").refresh()
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    _rec = ""
    require("lualine").refresh()
  end,
})

require("lualine").setup({
  options = {
    theme = theme,
    globalstatus = true,
    component_separators = "",
    section_separators = "",
    icons_enabled = true,
    refresh = {
      statusline = 500,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { { "mode", icon = "" } },
    lualine_b = {
      { git_repo_branch, padding = { left = 1, right = 1 } },
      {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        diff_color = {
          added = { fg = palette.light_green, gui = "bold" },
          modified = { fg = palette.yellow, gui = "bold" },
          removed = { fg = palette.red, gui = "bold" },
        },
      },
    },
    lualine_c = {
      { "filename", path = 1, symbols = { modified = " ", readonly = " ", unnamed = "" } },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        diagnostics_color = {
          error = { fg = palette.red, gui = "bold" },
          warn = { fg = palette.yellow, gui = "bold" },
          info = { fg = palette.sky_blue, gui = "bold" },
          hint = { fg = palette.light_green },
        },
      },
    },
    lualine_x = {
      { macro_recording, color = { fg = palette.red, gui = "bold" } },
      { "%S" },
      { lsp_progress },
      { "filetype", icon_only = false, colored = true },
    },
    lualine_y = {
      { word_reading },
      "encoding",
      "fileformat",
    },
    lualine_z = {
      { "location", separator = "", padding = { left = 1, right = 1 }, color = location_color },
      { "progress", color = percent_color },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "quickfix", "fugitive", "lazy" },
})
