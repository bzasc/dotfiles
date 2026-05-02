vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

-- Abbreviations: fix habits from other languages
local iabbrev = function(lhs, rhs)
  vim.keymap.set("ia", lhs, rhs, { buffer = true })
end

iabbrev("null", "nil")
iabbrev("none", "nil")
iabbrev("None", "nil")
iabbrev("elif", "elsif")
iabbrev("elseif", "elsif")
