vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })

vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("c", "<CR>", function()
  return vim.fn.getcmdtype() == "/" and "<CR>zzzv" or "<CR>"
end, { expr = true })

vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>ss", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

vim.keymap.set(
  "n",
  "<leader>on",
  ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
  { desc = "Add note ObsidianTemplate" }
)
vim.keymap.set(
  "n",
  "<leader>oc",
  ":ObsidianTemplate class-note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
  { desc = "Add class-note ObsidianTemplate" }
)
vim.keymap.set(
  "n",
  "<leader>od",
  ":ObsidianTemplate daily<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
  { desc = "Add class-note ObsidianTemplate" }
)
vim.keymap.set(
  "n",
  "<leader>os",
  '<cmd>FzfLua files cwd="/home/bzasc/annotations/bzasc_brain"<cr>',
  { desc = "Locate files in the Obsidian vault" }
)
vim.keymap.set(
  "n",
  "<leader>oz",
  '<cmd>FzfLua live_grep cwd="/home/bzasc/annotations/bzasc_brain"<cr>',
  { desc = "Search with ripgrep (rg) in the Obsidian vault" }
)

function _G.toggle_wrap()
  vim.wo.wrap = not vim.wo.wrap
  if vim.wo.wrap then
    print("Wrap: ON")
  else
    print("Wrap: OFF")
  end
end
vim.keymap.set("n", "<leader>Tw", ":lua toggle_wrap()<CR>", { desc = "Toggle line wrap" })

vim.keymap.set("n", "gs", function()
  vim.cmd("vsplit")
  vim.cmd("wincmd l")
  vim.lsp.buf.definition()
end, { noremap = true, silent = true, desc = "Go to definition split" })
