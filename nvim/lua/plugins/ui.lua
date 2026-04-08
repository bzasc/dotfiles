-- UI: Which-key, diagnostics display, notifications, and visual enhancements
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      delay = 250,
      sort = { "alphanum", "local", "order", "group", "mod" },
      icons = {
        mappings = false,
        rules = false,
        breadcrumb = "»",
        separator = "→",
        group = "+",
      },
      plugins = {
        marks = true,
        registers = true,
        spelling = { enabled = false },
      },
      win = {
        border = "rounded",
        padding = { 1, 2 },
      },
      spec = {
        mode = { "n", "v" },
        -- Top-level quick access
        { "<leader><space>", desc = "Find Files" },
        { "<leader>/", desc = "Grep" },
        { "<leader>,", desc = "Buffers" },
        { "<leader>.", desc = "Scratch" },
        { "<leader>e", desc = "Explorer" },
        { "<leader>q", desc = "Quit" },
        { "<leader>Q", desc = "Quit All" },
        -- Main groups
        { "<leader>b", group = "Buffers" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Diagnostics" },
        { "<leader>D", group = "Debug" },
        { "<leader>f", group = "Files" },
        { "<leader>g", group = "Git" },
        { "<leader>gh", group = "Hunks" },
        { "<leader>l", group = "LSP" },
        { "<leader>m", group = "Markdown" },
        { "<leader>n", group = "Notifications" },
        { "<leader>o", group = "Obsidian/Overseer" },
        { "<leader>s", group = "Search" },
        { "<leader>u", group = "UI/Toggle" },
        { "<leader>w", group = "Windows" },
        -- Navigation groups
        { "[", group = "Prev" },
        { "]", group = "Next" },
        { "g", group = "Goto" },
        -- Surround (mini.surround)
        { "gs", group = "Surround" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps",
      },
      {
        "<leader>K",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "All Keymaps",
      },
    },
  },

  {
    "echasnovski/mini.statusline",
    event = "VeryLazy",
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({
        use_icons = vim.g.have_nerd_font,
        set_vim_settings = false,
      })
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },

  {
    "echasnovski/mini.icons",
    enabled = true,
    opts = {},
    lazy = true,
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

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_theme = "dark"
      -- Enable mermaid, katex, and other features
      vim.g.mkdp_preview_options = {
        mermaid = { theme = "dark" },
        katex = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
      }
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview", ft = "markdown" },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    opts = {
      heading = {
        enabled = true,
        sign = false,
        icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
      },
      code = {
        enabled = true,
        sign = false,
        style = "full",
        left_pad = 1,
        right_pad = 1,
        border = "thin",
        language_pad = 1,
      },
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "☐ " },
        checked = { icon = "☑ " },
      },
      quote = { enabled = true, icon = "▎" },
      pipe_table = { enabled = true, style = "full" },
      callout = {
        note = { raw = "[!NOTE]", rendered = " Note", highlight = "RenderMarkdownInfo" },
        tip = { raw = "[!TIP]", rendered = " Tip", highlight = "RenderMarkdownSuccess" },
        important = { raw = "[!IMPORTANT]", rendered = " Important", highlight = "RenderMarkdownHint" },
        warning = { raw = "[!WARNING]", rendered = " Warning", highlight = "RenderMarkdownWarn" },
        caution = { raw = "[!CAUTION]", rendered = " Caution", highlight = "RenderMarkdownError" },
      },
    },
    keys = {
      { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", desc = "Render Markdown Toggle", ft = "markdown" },
    },
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    lazy = true,
    specs = {
      "folke/snacks.nvim",
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = require("trouble.sources.snacks").actions,
            win = {
              input = {
                keys = {
                  ["<c-t>"] = { "trouble_open", mode = { "n", "i" } },
                },
              },
            },
          },
        })
      end,
    },
    keys = {
      { "<leader>dt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble (workspace)" },
      { "<leader>dT", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble (buffer)" },
      { "<leader>dL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>dQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
      { "<leader>lt", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP References (Trouble)" },
      { "<leader>lT", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    },
    config = function()
      require("trouble").setup({
        mode = "workspace_diagnostics",
        position = "bottom",
        height = 20,
        padding = false,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = { "<cr>", "<tab>" },
          open_split = { "<c-x>" },
          open_vsplit = { "<c-v>" },
          open_tab = { "<c-t>" },
          jump_close = { "o" },
          toggle_mode = "m",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          close_folds = { "zM" },
          open_folds = { "zR" },
          toggle_fold = { "za" },
        },
        auto_jump = {},
        use_diagnostic_signs = true,
      })
    end,
  },

  {
    "itchyny/vim-highlighturl",
    event = "VeryLazy",
    config = function()
      -- Disable the plugin in some places where the default highlighting
      -- is preferred.
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Disable URL highlights",
        pattern = {
          "fzf",
          "lazyterm",
        },
        command = "call highlighturl#disable_local()",
      })
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    -- Lots of plugins will require this later.
    lazy = true,
    opts = {
      -- Make the icon for query files more visible.
      override = {
        scm = {
          icon = "󰘧",
          color = "#A9ABAC",
          cterm_color = "16",
          name = "Scheme",
        },
      },
    },
  },

  {
    "bngarren/checkmate.nvim",
    ft = "markdown",
    opts = {
      files = {
        "*.md", -- Any markdown file (basename matching)
        "**/todo.md", -- 'todo.md' anywhere in directory tree
      },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        hover = {
          silent = true,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      -- Use snacks for notifications
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
}
