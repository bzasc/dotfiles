vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("^1"),
  },
  "https://github.com/giuxtaposition/blink-cmp-copilot",
  "https://github.com/zbirenbaum/copilot.lua",
})

-- Lazy load on first insert mode entry
local group = vim.api.nvim_create_augroup("CompletionLazyLoad", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  group = group,
  once = true,
  callback = function()
    -- Copilot (inline suggestions disabled; fed through blink.cmp)
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
      appearance = {
        nerd_font_variant = "normal",
        use_nvim_cmp_as_default = false,
      },
      completion = {
        list = {
          -- Insert items while navigating the completion list.
          selection = { preselect = false, auto_insert = false },
          max_items = 10,
        },
        menu = {
          border = "rounded",
          scrolloff = 1,
          scrollbar = false,
          draw = {
            padding = 1,
            gap = 2,
            columns = {
              { "kind_icon", gap = 1 },
              { "label", "label_description", gap = 1 },
              { "kind" },
              { "source_name" },
            },
          },
        },
        documentation = {
          window = {
            border = "rounded",
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
          markdown = { "obsidian", "obsidian_new", "obsidian_tags", "lsp", "path", "snippets", "buffer" },
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
    })
  end,
})
