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

vim.keymap.set("n", "<leader>gr", function()
  local ok = pcall(function()
    Snacks.picker.grep_word({ ft = "ruby" })
  end)
  if not ok then
    vim.cmd("silent grep! " .. vim.fn.expand("<cword>") .. " --type ruby")
    vim.cmd("copen")
  end
end, { buffer = true, desc = "Ruby refs (ripgrep)" })
