---@type vim.lsp.Config
return {
  cmd = { "ruby-lsp" },
  filetypes = { "ruby" },
  root_markers = { "Gemfile", ".git" },
  on_attach = function(client, bufnr)
    vim.lsp.semantic_tokens.enable(true, { bufnr = bufnr })
  end,
  init_options = {
    formatter = "standard",
    linters = { "standard" },
    experimentalFeaturesEnabled = false,
    indexing = {
      excludedPatterns = {
        "**/test/**/*",
        "**/spec/**/*",
        "**/db/**/*",
        "**/vendor/**/*",
        "**/.git",
        "**/.svn",
        "**/.hg",
        "**/CVS",
        "**/.DS_Store",
        "**/tmp/**/*",
        "**/node_modules/**/*",
        "**/bower_components/**/*",
        "**/dist/**/*",
        "**/.git/objects/**",
        "**/.git/subtree-cache/**",
      },
      excludedGems = {
        "rubocop",
        "rubocop-ast",
        "rubocop-rake",
        "rubocop-rspec",
        "rubocop-rails",
        "bullet",
      },
    },
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
}
