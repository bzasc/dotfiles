---@type vim.lsp.Config
return {
  filetypes = { "ruby", "eruby" },
  --cmd = { "ruby-lsp" },
  cmd = { "mise", "x", "--", "ruby-lsp" },
  root_markers = { "Gemfile", ".git" },
  init_options = {
    formatter = "auto",
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
    rubyVersionManager = "mise",
  },
}
