return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    defaults = {
      ["<leader>r"] = { name = "+LSP" },
      ["<leader>f"] = { name = "+Find" },
      ["<leader>g"] = { name = "+Git" },
    },
  },
}
