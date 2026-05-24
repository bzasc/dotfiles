vim.pack.add({ "https://github.com/rachartier/tiny-cmdline.nvim" })

local tiny_cmdline = require("tiny-cmdline")

tiny_cmdline.setup({
  native_types = {},
  border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
})
