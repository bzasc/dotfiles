return {
  "mfussenegger/nvim-dap",
  config = function()
    vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
    vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
    vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
  end,
}
