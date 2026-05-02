-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disabled built-ins & providers
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- Indent
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- UI
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes:1"
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.ruler = true
vim.opt.showtabline = 0
vim.opt.cmdheight = 0 -- Noice handles cmdline
vim.opt.pumheight = 10
vim.opt.fillchars = { eob = " " }
vim.o.winborder = "rounded"

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Whitespace display
vim.opt.list = true
vim.opt.listchars = { space = " ", trail = "⋅", tab = "  ↦" }

-- Editing
vim.opt.backspace = "indent,eol,start"
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.confirm = true

-- Timing
vim.opt.updatetime = 500
vim.opt.ttimeoutlen = 0
vim.opt.timeoutlen = vim.g.vscode and 1000 or 300

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Files, Backup, Undo
vim.opt.fileencoding = "utf-8"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")

-- Scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Folding (treesitter)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-- Session & Completion
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.conceallevel = 0

-- Performance
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Ensure undodir exists
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

-- Filetype Detection
vim.filetype.add({
  extension = {
    env = "dotenv",
    txt = "markdown",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
  },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc",
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})
