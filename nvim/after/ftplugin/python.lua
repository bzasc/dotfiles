vim.api.nvim_create_autocmd("FileType", {
  pattern = "python", -- filetype for which to run the autocmd
  callback = function()
    -- use pep8 standards
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4

    -- folds based on indentation https://neovim.io/doc/user/fold.html#fold-indent
    -- if you are a heavy user of folds, consider using `nvim-ufo`
    -- vim.opt_local.foldmethod = "indent"

    local iabbrev = function(lhs, rhs)
      vim.keymap.set("ia", lhs, rhs, { buffer = true })
    end
    -- automatically capitalize boolean values. Useful if you come from a
    -- different language, and lowercase them out of habit.
    iabbrev("true", "True")
    iabbrev("false", "False")

    -- we can also fix other habits we might have from other languages
    iabbrev("--", "#")
    iabbrev("null", "None")
    iabbrev("none", "None")
    iabbrev("nil", "None")
    iabbrev("function", "def")
  end,
})
