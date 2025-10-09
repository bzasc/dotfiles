vim.opt.breakindent = true

vim.opt.relativenumber = true -- show relative line numbers
vim.opt.number = true -- shows absolute line number on cursor line (when relative number is on)

vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

vim.opt.list = true
vim.opt.listchars = { space = "⋅", trail = "⋅", tab = "  ↦" }

vim.opt.wrap = false -- disable line wrapping

vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

vim.opt.cursorline = true -- highlight the current cursor line

vim.opt.termguicolors = true
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes" -- show sign column so that text doesn't shift

vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

vim.opt.swapfile = false

vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.g.autoformat = true

vim.g.loaded_perl_provider = 0

function _G.toggle_wrap()
  vim.wo.wrap = not vim.wo.wrap
  if vim.wo.wrap then
    print("Wrap: ON")
  else
    print("Wrap: OFF")
  end
end
vim.keymap.set("n", "<leader>w", ":lua toggle_wrap()<CR>", { desc = "Toggle line wrap" })
