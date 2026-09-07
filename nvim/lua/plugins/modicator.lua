vim.pack.add({
  "https://github.com/mawkler/modicator.nvim",
})

local modicator = require("modicator")

modicator.setup({
  show_warnings = true,
})
