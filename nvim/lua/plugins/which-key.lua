return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    defaults = {
      ["<leader>c"] = { name = "+Code" },
      ["<leader>d"] = { name = "+Debug" },
      ["<leader>e"] = { name = "+Explore" },
      ["<leader>f"] = { name = "+Find" },
      ["<leader>g"] = { name = "+Lsp" },
      ["<leader>h"] = { name = "+Harpoon" },
      ["<leader>m"] = { name = "+Misc" },
      ["<leader>n"] = { name = "+Next/Swap" },
      ["<leader>o"] = { name = "+Obsidian" },
      ["<leader>p"] = { name = "+Prev/Swap" },
    },
  },
}
