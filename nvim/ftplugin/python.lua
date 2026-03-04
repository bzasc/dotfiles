-- Python-specific settings (PEP8 standards)
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

-- Abbreviations to fix common habits from other languages
local iabbrev = function(lhs, rhs)
  vim.keymap.set("ia", lhs, rhs, { buffer = true })
end

-- Automatically capitalize boolean values
iabbrev("true", "True")
iabbrev("false", "False")

-- Fix habits from other languages
iabbrev("--", "#")
iabbrev("null", "None")
iabbrev("none", "None")
iabbrev("nil", "None")
iabbrev("function", "def")
