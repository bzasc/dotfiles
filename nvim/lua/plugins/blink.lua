vim.pack.add({
  "https://github.com/xzbdmw/colorful-menu.nvim",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("^1"),
  },
  "https://github.com/giuxtaposition/blink-cmp-copilot",
  "https://github.com/zbirenbaum/copilot.lua",
})

-- Advertise blink.cmp completion capabilities to every LSP server so they
-- negotiate snippet/resolve/insertReplace support.
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- Copilot must be set up eagerly: :Copilot commands silently no-op until
-- setup() has run and the LSP client exists. Inline suggestions disabled;
-- completions are fed through blink.cmp.
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
  filetypes = {
    markdown = true,
    yaml = true,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
})

require("blink.cmp").setup({
  keymap = {
    preset = "enter",
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
    ["<C-j>"] = { "select_next" },
    ["<C-k>"] = { "select_prev" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  },
  completion = {
    list = {
      -- Insert items while navigating the completion list.
      selection = { preselect = false, auto_insert = false },
      max_items = 10,
    },
    menu = {
      scrolloff = 1,
      scrollbar = false,
      auto_show = function()
        return not vim.g.copilot_mode
      end,
      draw = {
        -- see https://github.com/xzbdmw/colorful-menu.nvim
        padding = { 1, 1 },
        columns = { { "kind_icon" }, { "label", gap = 1 }, { "kind" } },
        components = {
          kind = {
            highlight = "PmenuExtra",
          },
          label = {
            text = function(ctx)
              return require("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require("colorful-menu").blink_components_highlight(ctx)
            end,
          },
        },
      },
    },
    documentation = {
      window = {
        scrollbar = false,
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
      },
      auto_show = true,
      auto_show_delay_ms = 500,
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "lazydev", "copilot" },
    per_filetype = {
      -- obsidian.nvim serves completion through its built-in obsidian-ls LSP client now,
      -- so "lsp" covers refs/tags/new-note items; no dedicated obsidian sources anymore.
      markdown = { "lsp", "path", "snippets", "buffer", "copilot" },
    },
    providers = {
      copilot = { name = "copilot", module = "blink-cmp-copilot", score_offset = 100 },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  signature = {
    enabled = true,
  },
})

-- Subtle selection instead of sonokai's bright-blue PmenuSel.
local function blink_hl()
  vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#414550", bold = true })
end
blink_hl()
vim.api.nvim_create_autocmd("ColorScheme", { callback = blink_hl })
