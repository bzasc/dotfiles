-- Fixes Notify opacity issues
vim.o.termguicolors = true

local plugins = {
  require("plugins.mason"),
  require("plugins.alpha-nvim"),
  require("plugins.blink-cmp"),
  require("plugins.codex"),
  require("plugins.colorscheme"),
  require("plugins.comment"),
  require("plugins.conform"),
  require("plugins.dap"),
  require("plugins.dap-ui"),
  require("plugins.dap-python"),
  require("plugins.dressing"),
  require("plugins.flash"),
  require("plugins.harpoon"),
  require("plugins.harpoon-lualine"),
  require("plugins.iron"),
  require("plugins.lsp"),
  require("plugins.lualine"),
  require("plugins.mini"),
  require("plugins.noice"),
  require("plugins.neogen"),
  require("plugins.nvim-treesitter"),
  require("plugins.nvim-treesitter-text-objects"),
  require("plugins.ruby"),
  require("plugins.obsidian"),
  require("plugins.oil"),
  require("plugins.puppeteer"),
  require("plugins.telescope"),
  require("plugins.which-key"),
  require("plugins.checkmate"),
  require("plugins.wrapping"),
  require("plugins.extras"),
}

-- tell lazy.nvim to load and configure all the plugins
require("lazy").setup(plugins, {
  install = {
    colorscheme = { "catppuccin-mocha" },
  },
  checker = {
    enabled = false,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
