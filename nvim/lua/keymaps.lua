vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save File" })
vim.keymap.set({ "i", "x" }, "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save File" })

vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit All" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Highlight", silent = true })

vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit Insert" })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

vim.keymap.set("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next Match (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev Match (centered)" })
vim.keymap.set("n", "*", "*zzzv", { desc = "Search Word (centered)" })
vim.keymap.set("n", "#", "#zzzv", { desc = "Search Word Back (centered)" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half Page Down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half Page Up (centered)" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join Lines (keep cursor)" })
vim.keymap.set("n", "x", '"_x')

-- Window resizing
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Width" })

vim.keymap.set("c", "<CR>", function()
  return vim.fn.getcmdtype() == "/" and "<CR>zzzv" or "<CR>"
end, { expr = true })

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement


-- Better indenting (stay in visual mode)
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

-- Paste over selection without yanking (visual `p` handled by yanky.nvim)
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- Yank block
vim.keymap.set("n", "YY", "va{Vy", { desc = "Yank Block {}" })

-- Split line (opposite of J)
vim.keymap.set(
  "n",
  "X",
  ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>",
  { desc = "Split Line", silent = true }
)

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select All" })

vim.keymap.set(
  "n",
  "<leader>oN",
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
  { desc = "Add daily ObsidianTemplate" }
)

local obsidian_vault = vim.env.HOME .. "/annotations/bzasc_brain"

vim.keymap.set("n", "<leader>os", function()
  Snacks.picker.files({ cwd = obsidian_vault })
end, { desc = "Locate files in the Obsidian vault" })

vim.keymap.set("n", "<leader>oz", function()
  Snacks.picker.live_grep({ cwd = obsidian_vault })
end, { desc = "Search with ripgrep (rg) in the Obsidian vault" })

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
