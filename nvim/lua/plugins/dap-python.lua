-- Configuration for the python debugger
-- * configures debugpy for us
-- * uses the debugpy installation from mason
return {
	"mfussenegger/nvim-dap-python",
	dependencies = "mfussenegger/nvim-dap",
	config = function()
		-- fix: E5108: Error executing lua .../Local/nvim-data/lazy/nvim-dap-ui/lua/dapui/controls.lua:14: attempt to index local 'element' (a nil value)
		-- see: https://github.com/rcarriga/nvim-dap-ui/issues/279#issuecomment-1596258077
		require("dapui").setup()
		-- uses the debugypy installation by mason
		require("dap-python").setup("~/.pyenv/versions/neovim/bin/python", {})
	end,
}
