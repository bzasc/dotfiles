-- Fixes Notify opacity issues
vim.o.termguicolors = true

local plugins = {
  --require("plugins.which-key"),
  require("plugins.lspconfig"),
  require("plugins.conform"),
  require("plugins.blink-cmp"),
  require("plugins.colorscheme"),
  require("plugins.dap"),
  require("plugins.dap-ui"),
  require("plugins.dap-python"),
  require("plugins.flash"),
  require("plugins.lualine"),
  require("plugins.miniai"),
  require("plugins.miniclue"),
  require("plugins.minifiles"),
  require("plugins.minisplitjoin"),
  require("plugins.minimove"),
  require("plugins.minibufremove"),
  require("plugins.minicomment"),
  require("plugins.minisurround"),
  require("plugins.noice"),
  require("plugins.ruby"),
  require("plugins.obsidian"),
  require("plugins.fzf-lua"),
  require("plugins.checkmate"),
  require("plugins.markdown-preview"),
  require("plugins.indent-blankline"),
  require("plugins.treesitter"),
  require("plugins.telescope"),
  --require("plugins.no-neck-pain"),
  require("plugins.venv-selector"),
  require("plugins.miniicons"),
  require("plugins.nvim-web-devicons"),
  require("plugins.extras"),
}

-- tell lazy.nvim to load and configure all the plugins
require("lazy").setup(plugins, {
  checker = {
    enabled = false,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
