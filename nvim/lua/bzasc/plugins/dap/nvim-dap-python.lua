return {
  "mfussenegger/nvim-dap-python",
  config = function()
    require("dap-python").setup("~/.pyenv/versions/debugpy/bin/python", {})

    table.insert(require("dap").configurations.python, {
      type = "python",
      request = "attach",
      connect = {
        port = 5678,
        host = "127.0.0.1",
      },
      mode = "remote",
      name = "Container Attach Debug",
      cwd = vim.fn.getcwd(),
      pathMappings = {
        {
          localRoot = function()
            return vim.fn.input("Local code folder > ", vim.fn.getcwd(), "file")
          end,
          remoteRoot = function()
            return vim.fn.input("Container code folder > ", "/", "file")
          end,
        },
      },
    })
    require("dap-python").test_runner = "pytest"

    vim.keymap.set("n", "<leader>dn", ":lua require('dap-python').test_method()<CR>")
    vim.keymap.set("n", "<leader>df", ":lua require('dap-python').test_class()<CR>")
  end,
}
