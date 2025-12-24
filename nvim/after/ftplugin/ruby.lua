-- Ruby-specific settings
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

-- Abbreviations to fix common habits from other languages
local iabbrev = function(lhs, rhs)
  vim.keymap.set("ia", lhs, rhs, { buffer = true })
end

-- Fix habits from other languages
iabbrev("null", "nil")
iabbrev("none", "nil")
iabbrev("None", "nil")
iabbrev("elif", "elsif")
iabbrev("elseif", "elsif")
