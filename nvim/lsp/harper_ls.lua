-- Grammar/spell checking. Not listed in `servers_by_ft` on purpose: it is
-- toggled on demand together with 'spell' via <leader>us (see config/keymaps).
---@type vim.lsp.Config
return {
  cmd = { "harper-ls", "--stdio" },
  filetypes = { "markdown", "text", "gitcommit", "org" },
  root_markers = { ".git" },
  settings = {
    ["harper-ls"] = {
      linters = {
        SentenceCapitalization = false,
        SpellCheck = true,
        LongSentences = false,
        Spaces = false,
      },
      isolateEnglish = false,
      markdown = {
        IgnoreLinkTitle = true,
      },
    },
  },
}
