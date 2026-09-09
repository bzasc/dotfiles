vim.pack.add({
  "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
})

local tiny_inline_diagnostic = require("tiny-inline-diagnostic")

tiny_inline_diagnostic.setup({
  options = {
    multilines = {
      enabled = true,
    },
  },
})
