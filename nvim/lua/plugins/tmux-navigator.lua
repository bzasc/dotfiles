-- Disable default mappings BEFORE plugin loads so it doesn't claim <C-h/j/k/l>
vim.g.tmux_navigator_no_mappings = 1

vim.pack.add({
  "https://github.com/christoomey/vim-tmux-navigator",
})

local map = vim.keymap.set

map("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate left" })
map("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate down" })
map("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate up" })
map("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate right" })
map("n", [[<c-\>]], "<cmd>TmuxNavigatePrevious<cr>", { desc = "Navigate previous" })

map("t", "<c-h>", [[<C-\><C-n><cmd>TmuxNavigateLeft<cr>]], { desc = "Navigate left" })
map("t", "<c-j>", [[<C-\><C-n><cmd>TmuxNavigateDown<cr>]], { desc = "Navigate down" })
map("t", "<c-k>", [[<C-\><C-n><cmd>TmuxNavigateUp<cr>]], { desc = "Navigate up" })
map("t", "<c-l>", [[<C-\><C-n><cmd>TmuxNavigateRight<cr>]], { desc = "Navigate right" })
map("t", [[<c-\>]], [[<C-\><C-n><cmd>TmuxNavigatePrevious<cr>]], { desc = "Navigate previous" })
