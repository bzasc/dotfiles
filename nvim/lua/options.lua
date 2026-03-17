vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrw = 1 -- Disable netrw file explorer (using a different file explorer)
vim.g.loaded_netrwPlugin = 1 -- Disable netrw plugin component
vim.g.loaded_node_provider = 0 -- Disable Node.js provider
vim.g.loaded_perl_provider = 0 -- Disable Perl provider

vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

vim.opt.termguicolors = true -- Enable 24-bit RGB colors in the terminal
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers (hybrid with number=true)
vim.opt.numberwidth = 4 -- Minimum width of number column
vim.opt.signcolumn = "yes:1" -- Always show sign column with width of 1
vim.opt.cursorline = true -- Highlight the current line
vim.opt.wrap = false -- Don't wrap long lines
vim.opt.breakindent = true -- Wrapped lines preserve indentation
vim.opt.showmode = false -- Don't show mode in command line (shown in statusline)
vim.opt.showcmd = false -- Don't show partial command in command line
vim.opt.ruler = true -- Show cursor position in command line
vim.opt.showtabline = 0 -- Never show the tab line
vim.opt.cmdheight = 0 -- Let Noice handle the command line UI
vim.opt.pumheight = 10 -- Maximum height of popup menu
vim.opt.fillchars = { eob = " " } -- Hide ~ characters on empty lines
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.o.winborder = "rounded" -- Use rounded borders for floating windows

vim.opt.hlsearch = true -- Highlight all search matches
vim.opt.incsearch = true -- Show search matches as you type
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override ignorecase if pattern contains uppercase

vim.opt.list = true
vim.opt.listchars = { space = "⋅", trail = "⋅", tab = "  ↦" }

vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

vim.opt.mouse = "a" -- Enable mouse support in all modes
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for all yank/paste operations
vim.opt.undofile = true -- Persist undo history to disk between sessions
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo" -- Directory to store undo files
vim.opt.updatetime = 100 -- Time in ms before CursorHold event triggers (affects plugins)
vim.opt.timeoutlen = 1000 -- Time in ms to wait for a mapped key sequence to complete
vim.opt.confirm = true -- Prompt for confirmation instead of failing on unsaved changes
vim.opt.autoread = true -- Automatically reload files changed outside of Neovim

vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

vim.opt.fileencoding = "utf-8" -- File encoding for new files
vim.opt.backup = false -- Don't create backup files before overwriting
vim.opt.writebackup = false -- Don't create backup while editing
vim.opt.swapfile = false -- Don't create swap files

vim.opt.scrolloff = 8 -- minimum lines to keep above/below cursor
vim.opt.sidescrolloff = 8 -- minimum columns to keep left/right of cursor

vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- treesitter-based folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Completion menu options
vim.opt.conceallevel = 0 -- Show all text normally (no concealment)

-- Filetype Detection
vim.filetype.add({
  extension = {
    env = "dotenv", -- Treat .env extension as dotenv filetype
  },
  filename = {
    [".env"] = "dotenv", -- Treat .env file as dotenv filetype
    ["env"] = "dotenv", -- Treat env file as dotenv filetype
  },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc", -- Treat tsconfig/jsconfig files as JSONC (allows comments)
    ["%.env%.[%w_.-]+"] = "dotenv", -- Treat .env.* files as dotenv filetype
  },
})
