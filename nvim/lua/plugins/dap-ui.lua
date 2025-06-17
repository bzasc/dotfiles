-- UI for the debugger
-- * the debugger UI is also automatically opened when starting/stopping the debugger
-- * toggle debugger UI manually with `<leader>du`
return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	keys = {
		{
			"<leader>du",
			function()
				require("dapui").toggle()
			end,
			desc = "Toggle Debugger UI",
		},
	},
	-- automatically open/close the DAP UI when starting/stopping the debugger
	config = function()
		local listener = require("dap").listeners
		listener.after.event_initialized["dapui_config"] = function()
			require("dapui").open()
		end
		listener.before.event_terminated["dapui_config"] = function()
			require("dapui").close()
		end
		listener.before.event_exited["dapui_config"] = function()
			require("dapui").close()
		end
	end,
}
