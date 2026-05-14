---@type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "ruff.toml",
    ".ruff.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".jj",
    ".git",
  },
  init_options = {
    settings = {
      logLevel = "warn",
      organizeImports = true, -- use code action for organizeImports
      showSyntaxErrors = true, -- show syntax error diagnostics
      codeAction = {
        disableRuleComment = { enable = false }, -- show code action about rule disabling
        fixViolation = { enable = false }, -- show code action for autofix violation
      },
      format = { -- use conform.nvim
        preview = false,
      },
      lint = { -- it links with ruff, but lint.args are different with ruff configuration
        enable = true,
      },
    },
  },
  single_file_support = false,
}
