vim.pack.add({
  "https://github.com/rachartier/tiny-cmdline.nvim",
  "https://github.com/rachartier/tiny-code-action.nvim",
})

local cmdline = require("tiny-cmdline")
cmdline.setup({
  on_reposition = cmdline.adapters.blink,
})

local code_action = require("tiny-code-action")
code_action.setup({
  picker = "buffer",
})

local function fix_hl()
  vim.api.nvim_set_hl(0, "TinyCmdlineNormal", { link = "NormalFloat" })
end
fix_hl()

vim.api.nvim_create_autocmd("ColorScheme", { callback = fix_hl })
