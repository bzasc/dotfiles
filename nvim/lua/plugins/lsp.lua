return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  { "b0o/SchemaStore.nvim", lazy = true },

  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "classic",
        transparent_bg = false,
        transparent_cursorline = false,
        hi = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
          arrow = "NonText",
          background = "CursorLine",
          mixing_color = "None",
        },
        options = {
          show_source = { enabled = false, if_many = false },
          use_icons_from_diagnostic = false,
          set_arrow_to_diag_color = false,
          add_messages = true,
          throttle = 20,
          softwrap = 30,
          multilines = { enabled = false, always_show = false },
          show_all_diags_on_cursorline = false,
          enable_on_insert = false,
          enable_on_select = false,
          overflow = { mode = "wrap", padding = 0 },
          break_line = { enabled = false, after = 30 },
          format = nil,
          virt_texts = { priority = 2048 },
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },
          overwrite_events = nil,
        },
        disabled_ft = {},
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
