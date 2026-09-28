vim.pack.add({
  "https://github.com/rachartier/tiny-code-action.nvim",
})

local code_action = require("tiny-code-action")
code_action.setup({
  picker = "buffer",
})
