---@type vim.lsp.Config
return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  root_markers = { "package.json", ".git" },
  embeddedLanguages = { css = true, javascript = true },
}
