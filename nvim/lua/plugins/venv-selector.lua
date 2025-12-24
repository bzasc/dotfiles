return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      -- Picker will use fzf-lua via vim.ui.select (no Telescope required)
    },
    ft = "python", -- Load when opening Python files
    keys = {
      { "<leader>vv", "<cmd>VenvSelect<cr>", desc = "Select Python virtual environment" },
    },
    opts = { -- this can be an empty lua table - just showing below for clarity.
      search = {}, -- if you add your own searches, they go here.
      options = {}, -- if you add plugin options, they go here.
    },
  },
}
