return {
  --{
  --  "adam12/ruby-lsp.nvim",
  --  dependencies = {
  --    "nvim-lua/plenary.nvim",
  --    "neovim/nvim-lspconfig",
  --  },
  --  config = true,
  --},
  -- Rails navigation, commands, and helpers
  { "tpope/vim-rails", ft = { "ruby", "eruby" } },
  -- Bundler helpers (:Bundle, gf to Gemfile paths)
  { "tpope/vim-bundler", ft = "ruby" },
  -- Rake helpers
  { "tpope/vim-rake", ft = "ruby" },
}
