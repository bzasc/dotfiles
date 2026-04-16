return {
  {
    "sainnhe/sonokai",
    priority = 1000,
    lazy = false,
    config = function()
      vim.g.sonokai_enable_italic = true
      --vim.g.sonokai_colors_override = { bg0 = { "#1C2021", "235" } }
      vim.cmd.colorscheme("sonokai")
    end,
  },
  --{
  --  "AlexvZyl/nordic.nvim",
  --  lazy = false,
  --  priority = 1000,
  --  config = function()
  --    require("nordic").load()
  --    vim.cmd.colorscheme("nordic")
  --  end,
  --},
  --{
  --  "sainnhe/gruvbox-material",
  --  --priority = 1000,
  --  lazy = true,
  --  config = function()
  --    -- vim.g.gruvbox_material_transparent_background = 1
  --    vim.g.gruvbox_material_foreground = "mix"
  --    vim.g.gruvbox_material_background = "hard"
  --    vim.g.gruvbox_material_ui_contrast = "high"
  --    vim.g.gruvbox_material_float_style = "bright"
  --    vim.g.gruvbox_material_statusline_style = "mix"
  --    vim.g.gruvbox_material_cursor = "auto"
  --  end,
  --},
  --{
  --  "rebelot/kanagawa.nvim",
  --  --priority = 1000, -- Load before other plugins
  --  lazy = true,
  --  config = function()
  --    -- Default options:
  --    require("kanagawa").setup({
  --      compile = false, -- enable compiling the colorscheme
  --      undercurl = false, -- enable undercurls
  --      commentStyle = { italic = false },
  --      functionStyle = { bold = true },
  --      keywordStyle = { italic = false, bold = true },
  --      statementStyle = { bold = true },
  --      typeStyle = { bold = true },
  --      transparent = false, -- do not set background color
  --      dimInactive = true, -- dim inactive window `:h hl-NormalNC`
  --      terminalColors = true, -- define vim.g.terminal_color_{0,17}
  --      colors = { -- add/modify theme and palette colors
  --        palette = {},
  --        theme = {
  --          wave = {},
  --          lotus = {},
  --          dragon = {},
  --          all = {
  --            ui = {
  --              bg_gutter = "none",
  --            },
  --          },
  --        },
  --      },
  --      overrides = function(colors) -- add/modify highlights
  --        return {}
  --      end,
  --      theme = "wave", -- Load "wave" theme when 'background' option is not set
  --      background = { -- map the value of 'background' option to a theme
  --        dark = "dragon", -- try "dragon" !
  --        light = "lotus",
  --      },
  --    })

  --    -- setup must be called before loading
  --    -- vim.cmd("colorscheme kanagawa")
  --  end,
  --},
}
