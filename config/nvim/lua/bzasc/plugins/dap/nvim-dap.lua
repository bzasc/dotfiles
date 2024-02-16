return {
  "mfussenegger/nvim-dap",
  config = function()
    vim.keymap.set("n", "<F5>", function()
      require("dap").continue()
    end)
    vim.keymap.set("n", "<F10>", function()
      require("dap").step_over()
    end)
    vim.keymap.set("n", "<F11>", function()
      require("dap").step_into()
    end)
    vim.keymap.set("n", "<F12>", function()
      require("dap").step_out()
    end)
    vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
    vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
    vim.keymap.set("n", "<Leader>ds", ":DapStepOver<CR>")
  end,
}
