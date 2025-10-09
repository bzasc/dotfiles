return {
  "saghen/blink.cmp",
  build = "cargo +nightly build --release",
  event = "VimEnter",
  dependencies = {
    -- Snippet Engine
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      build = (function()
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {},
      opts = {},
    },
    "folke/lazydev.nvim",
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      preset = "enter",
      ["<C-j>"] = { "select_next" },
      ["<C-k>"] = { "select_prev" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      list = {
        -- Insert items while navigating the completion list.
        selection = { preselect = false, auto_insert = true },
        max_items = 10,
      },

      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      menu = { scrollbar = false },
    },

    cmdline = { enabled = false },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },

    snippets = { preset = "luasnip" },

    signature = { enabled = true },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
