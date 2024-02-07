return {
    "mfussenegger/nvim-dap-python",
    config = function()
        require("dap-python").setup("~/.pyenv/versions/neovim/bin/python", {})
        table.insert(require("dap").configurations.python, {
            type = "python",
            request = "attach",
            connect = {
                port = 8000,
                host = "127.0.0.1",
            },
            mode = "remote",
            name = "Container Attach Debug",
            cwd = vim.fn.getcwd(),
            pathMappings = {
                {
                    localRoot = function()
                        return vim.fn.input("Local code folder > ", vim.fn.getcwd(), "file")
                        --"/home/alpha2phi/workspace/alpha2phi/python-apps/ml-yolo/backend", -- Local folder the code lives
                    end,
                    remoteRoot = function()
                        return vim.fn.input("Container code folder > ", "/", "file")
                        -- "/fastapi", -- Wherever your Python code lives in the container.
                    end,
                },
            },
        })
    end,
}
