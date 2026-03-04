local api = vim.api

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- wrap words "softly" (no carriage return) in mail buffer
api.nvim_create_autocmd("Filetype", {
  pattern = "mail",
  callback = function()
    vim.opt.textwidth = 0
    vim.opt.wrapmargin = 0
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.columns = 80
    vim.opt.colorcolumn = "80"
  end,
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})

-- go to last loc when opening a buffer
-- this mean that when you open a file, you will be at the last position
api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = "set cursorline",
  group = cursorGrp,
})
api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- Enable spell checking for certain file types
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md", "*.tex" },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = "en"
  end,
})

-- close some filetypes with <q>
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Resize neovim split when terminal is resized
api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("wincmd =")
  end,
})

-- Fix terraform and hcl comment string
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
  pattern = { "terraform", "hcl" },
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
})

-- Check for external file changes (works with Claude Code)
api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, { -- CursorHold
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

--vim.api.nvim_create_autocmd("FileType", {
--  group = vim.api.nvim_create_augroup("bzasc/big_file", { clear = true }),
--  desc = "Disable features in big files",
--  pattern = "bigfile",
--  callback = function(args)
--    vim.schedule(function()
--      vim.bo[args.buf].syntax = vim.filetype.match({ buf = args.buf }) or ""
--    end)
--  end,
--})

--vim.api.nvim_create_autocmd("CmdwinEnter", {
--  group = vim.api.nvim_create_augroup("bzasc/execute_cmd_and_stay", { clear = true }),
--  desc = "Execute command and stay in the command-line window",
--  callback = function(args)
--    vim.keymap.set({ "n", "i" }, "<S-CR>", "<cr>q:", { buffer = args.buf })
--  end,
--})

--vim.api.nvim_create_autocmd("FileType", {
--  group = vim.api.nvim_create_augroup("bzasc/treesitter_folding", { clear = true }),
--  desc = "Enable Treesitter folding",
--  callback = function(args)
--    local bufnr = args.buf
--
--    -- Enable Treesitter folding when not in huge files and when Treesitter
--    -- is working.
--    if vim.bo[bufnr].filetype ~= "bigfile" and pcall(vim.treesitter.start, bufnr) then
--      vim.api.nvim_buf_call(bufnr, function()
--        vim.wo[0][0].foldmethod = "expr"
--        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
--        vim.cmd.normal("zx")
--      end)
--    end
--  end,
--})

--api.nvim_create_autocmd("TextYankPost", {
--  group = vim.api.nvim_create_augroup("bzasc/yank_highlight", { clear = true }),
--  desc = "Highlight on yank",
--  callback = function()
--    vim.hl.on_yank({ higroup = "Visual" })
--  end,
--})
