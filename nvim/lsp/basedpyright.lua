---@type vim.lsp.Config
return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyrightconfig.json",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".git",
  },
  settings = {
    basedpyright = {
      -- ruff handles import sorting; pyrefly owns type diagnostics.
      -- basedpyright here is ONLY for navigation/hover/completion/refs.
      disableOrganizeImports = true,
      analysis = {
        autoSearchPaths = true, -- resolve imports against project + venv
        useLibraryCodeForTypes = true, -- jump into 3rd-party/stdlib sources
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "off", -- no duplicate diagnostics with pyrefly
      },
    },
  },
}
