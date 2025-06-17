-- MASON
-- * Manager for external tools (LSPs, linters, debuggers, formatters)
-- * auto-install those external tools
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		{ "williamboman/mason.nvim", opts = true },
		{ "williamboman/mason-lspconfig.nvim", opts = true },
	},
	opts = {
		ensure_installed = {
			"pyright", -- LSP for python
			"ruff", -- linter & formatter (includes flake8, pep8, black, isort, etc.)
			"debugpy", -- debugger
			"taplo", -- LSP for toml (e.g., for pyproject.toml files)
			"prettier", -- opinionated code formatter,
			"stylua", -- A lua code formatter
		},
	},
}
