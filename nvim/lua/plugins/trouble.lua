vim.pack.add({
	"https://github.com/folke/trouble.nvim",
	"https://github.com/folke/todo-comments.nvim",
})

require("trouble").setup()
require("todo-comments").setup()

vim.keymap.set("n", "<leader>tr", "<cmd>Trouble diagnostics toggle<cr>", { silent = true, desc = "Trouble Diagnostics" })
vim.keymap.set("n", "<leader>td", "<cmd>Trouble todo toggle<cr>", { silent = true, desc = "Trouble Todo" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { silent = true, desc = "Quickfix List (Trouble)" })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { silent = true, desc = "Location List (Trouble)" })

-- Reroute native quickfix / location list windows into Trouble. Location
-- lists also have buftype=quickfix, so tell them apart by window type.
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("TroubleQuickfix", { clear = true }),
	callback = function(ev)
		if vim.bo[ev.buf].buftype ~= "quickfix" then
			return
		end
		vim.schedule(function()
			local win = vim.fn.bufwinid(ev.buf)
			if win ~= -1 and vim.fn.win_gettype(win) == "loclist" then
				pcall(vim.cmd.lclose)
				vim.cmd([[Trouble loclist open]])
			else
				pcall(vim.cmd.cclose)
				vim.cmd([[Trouble qflist open]])
			end
		end)
	end,
})
