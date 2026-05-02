local map = vim.keymap.set

-- File & Session
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save File" })
map({ "i", "x" }, "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save File" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit All" })

-- Insert Mode
map("i", "jj", "<Esc>", { desc = "Exit Insert" })
map("i", "jk", "<Esc>", { desc = "Exit Insert" })

-- Movement
map("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
map("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

map("n", "<C-d>", "<C-d>zz", { desc = "Half Page Down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half Page Up (centered)" })

-- Search
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Highlight", silent = true })
map("n", "n", "nzzzv", { desc = "Next Match (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev Match (centered)" })
map("n", "*", "*zzzv", { desc = "Search Word (centered)" })
map("n", "#", "#zzzv", { desc = "Search Word Back (centered)" })

map("c", "<CR>", function()
  return vim.fn.getcmdtype() == "/" and "<CR>zzzv" or "<CR>"
end, { expr = true })

-- Editing
map("n", "J", "mzJ`z", { desc = "Join Lines (keep cursor)" })
map(
  "n",
  "X",
  ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>",
  { desc = "Split Line", silent = true }
)
map("n", "x", '"_x')

map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Yank, Paste, Delete
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to System" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank Line to System" })
map("n", "YY", "va{Vy", { desc = "Yank Block {}" })
map("x", "<leader>p", [["_dP]], { desc = "Paste Without Yank" })
map({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete Without Yanking" })

-- Selection
map("n", "<C-a>", "ggVG", { desc = "Select All" })

-- Windows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Width" })

-- LSP
map("n", "gs", function()
  vim.cmd("vsplit")
  vim.cmd("wincmd l")
  vim.lsp.buf.definition()
end, { noremap = true, silent = true, desc = "Go to definition split" })

-- Marks
map("n", "dm", function()
  local mark = vim.fn.getcharstr("Delete mark: ")
  vim.cmd("delmarks " .. mark)
end, { desc = "Delete mark" })

-- Obsidian
local obsidian_vault = vim.env.HOME .. "/annotations/bzasc_brain"

map(
  "n",
  "<leader>oN",
  ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
  { desc = "Add note ObsidianTemplate" }
)
map(
  "n",
  "<leader>oc",
  ":ObsidianTemplate class-note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
  { desc = "Add class-note ObsidianTemplate" }
)
map(
  "n",
  "<leader>od",
  ":ObsidianTemplate daily<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
  { desc = "Add daily ObsidianTemplate" }
)
map("n", "<leader>os", function()
  Snacks.picker.files({ cwd = obsidian_vault })
end, { desc = "Locate files in Obsidian vault" })
map("n", "<leader>oz", function()
  Snacks.picker.live_grep({ cwd = obsidian_vault })
end, { desc = "Ripgrep in Obsidian vault" })
