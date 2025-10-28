--return {
--  "saghen/blink.cmp",
--  build = "cargo +nightly build --release",
--  event = "VimEnter",
--  dependencies = {
--    -- Snippet Engine
--    {
--      "L3MON4D3/LuaSnip",
--      version = "2.*",
--      build = (function()
--        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
--          return
--        end
--        return "make install_jsregexp"
--      end)(),
--      dependencies = {},
--      opts = {},
--    },
--    "folke/lazydev.nvim",
--  },
--  --- @module 'blink.cmp'
--  --- @type blink.cmp.Config
--  opts = {
--    keymap = {
--      preset = "enter",
--      ["<C-j>"] = { "select_next" },
--      ["<C-k>"] = { "select_prev" },
--    },
--
--    appearance = {
--      nerd_font_variant = "mono",
--    },
--
--    completion = {
--      list = {
--        -- Insert items while navigating the completion list.
--        selection = { preselect = false, auto_insert = true },
--        max_items = 10,
--      },
--
--      documentation = { auto_show = true, auto_show_delay_ms = 200 },
--      menu = {
--        scrollbar = false,
--        draw = {
--          treesitter = { "lsp" },
--          columns = {
--            { "label", gap = 2 },
--            { "kind_icon", gap = 1, "kind" },
--          },
--        },
--      },
--    },
--
--    cmdline = { enabled = false },
--
--    sources = {
--      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
--      providers = {
--        lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
--      },
--      lsp = {
--        fallbacks = { "buffer", "path" },
--      },
--    },
--
--    snippets = { preset = "luasnip" },
--
--    signature = { enabled = true },
--
--    fuzzy = { implementation = "prefer_rust_with_warning" },
--  },
--  opts_extend = { "sources.default" },
--}
-- Auto-completion:
return {
  {
    "saghen/blink.cmp",
    dependencies = "LuaSnip",
    build = "cargo +nightly build --release",
    event = "InsertEnter",
    opts = {
      keymap = {
        preset = "enter",
        ["<C-j>"] = { "select_next" },
        ["<C-k>"] = { "select_prev" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      completion = {
        list = {
          -- Insert items while navigating the completion list.
          selection = { preselect = false, auto_insert = true },
          max_items = 10,
        },
        documentation = { auto_show = true },
        menu = { scrollbar = false },
      },
      snippets = { preset = "luasnip" },
      -- Disable command line completion:
      cmdline = { enabled = false },
      sources = {
        -- Disable some sources in comments and strings.
        default = function()
          local sources = { "lsp", "buffer" }
          local ok, node = pcall(vim.treesitter.get_node)

          if ok and node then
            if not vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
              table.insert(sources, "path")
            end
            if node:type() ~= "string" then
              table.insert(sources, "snippets")
            end
          end

          return sources
        end,
        ---per_filetype = {
        ---  codecompanion = { "codecompanion", "buffer" },
        ---},
      },
      appearance = {
        kind_icons = require("icons").symbol_kinds,
      },
    },
    config = function(_, opts)
      require("blink.cmp").setup(opts)

      -- Extend neovim's client capabilities with the completion ones.
      vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities(nil, true) })
    end,
  },
}
