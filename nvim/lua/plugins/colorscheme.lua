return {
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_enable_italic = true
      --vim.g.sonokai_colors_override = { bg0 = { "#1C2021", "235" } }
      vim.cmd.colorscheme("sonokai")
    end,
  },
  {
    "catgoose/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*",
        css = { rgb_fn = true },
      })
    end,
  },
}
