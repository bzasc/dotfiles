vim.pack.add({
  "https://github.com/j-hui/fidget.nvim",
})

local fidget = require("fidget")

fidget.setup({
  progress = { -- make fidget less noisy
    suppress_on_insert = true, -- suppress new messages while in insert mode -- default: false
    ignore_done_already = true, -- ignore new tasks that are already complete -- default: false
    ignore_empty_message = true, -- ignore new tasks that don't contain a message  default: false
    display = {
      done_ttl = 1, -- time a message persist after completion
    },
  },
})
