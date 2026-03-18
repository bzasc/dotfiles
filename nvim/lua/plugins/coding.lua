-- Coding: Completion, treesitter, and dev tools
return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "fang2hou/blink-copilot",
    },
    config = function()
      require("blink.cmp").setup({
        snippets = { preset = "luasnip" },
        signature = { enabled = true },
        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "normal",
        },
        fuzzy = {
          implementation = "prefer_rust",
        },
        cmdline = {
          enabled = false,
          completion = { menu = { auto_show = true } },
        },
        --cmdline = {
        --  keymap = { preset = "inherit" },
        --  completion = {
        --    menu = { auto_show = true },
        --    ghost_text = { enabled = true },
        --  },
        --},
        sources = {
          default = { "lsp", "path", "buffer", "snippets", "copilot" },
          per_filetype = {
            lua = { inherit_defaults = true, "lazydev" },
          },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
            copilot = {
              name = "copilot",
              module = "blink-copilot",
              async = true,
            },
            cmdline = {
              min_keyword_length = 2,
            },
          },
        },
        keymap = {
          preset = "enter",
          ["<C-space>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
          ["<C-j>"] = { "select_next" },
          ["<C-k>"] = { "select_prev" },
          ["<C-b>"] = { "scroll_documentation_up", "fallback" },
          ["<C-f>"] = {},
          ["<Tab>"] = {
            "snippet_forward",
            function() -- sidekick next edit suggestion
              return require("sidekick").nes_jump_or_apply()
            end,
            function() -- if you are using Neovim's native inline completions
              return vim.lsp.inline_completion.get()
            end,
            "fallback",
          },
        },
        completion = {
          list = {
            -- Insert items while navigating the completion list.
            selection = { preselect = false, auto_insert = true },
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
      })
    end,
  },
  {
    "nvim-neorg/neorg",
    ft = "norg", -- lazy load on filetype
    cmd = "Neorg", -- lazy load on command, allows you to autocomplete :Neorg regardless of whether it's loaded yet
    --  (you could also just remove both lazy loading things)
    priority = 30, -- treesitter is on default priority of 50, neorg should load after it.
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup()

      -- ensure_installed is no longer handled by setup() in the new nvim-treesitter
      local ensure_installed = {
        "bash",
        "c",
        "css",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "javascript",
        "json",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "php",
        "proto",
        "python",
        "query",
        "regex",
        "ruby",
        "rust",
        "scss",
        "svelte",
        "swift",
        "terraform",
        "tsx",
        "typst",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "yaml",
        "zig",
      }

      local installed = require("nvim-treesitter.config").get_installed()
      local to_install = vim.tbl_filter(function(lang)
        return not vim.list_contains(installed, lang)
      end, ensure_installed)

      if #to_install > 0 then
        require("nvim-treesitter.install").install(to_install)
      end
      -- Enable treesitter-based highlighting and indentation
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
      vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  {
    "numToStr/Comment.nvim",
    lazy = false,
    dependencies = { "joosepalviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  { "joosepalviste/nvim-ts-context-commentstring", lazy = true, opts = { enable_autocmd = false } },

  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    keys = {
      {
        "<C-r>s",
        function()
          require("luasnip.extras.otf").on_the_fly("s")
        end,
        desc = "Insert on-the-fly snippet",
        mode = "i",
      },
    },
    opts = function()
      local types = require("luasnip.util.types")
      return {
        -- Check if the current snippet was deleted.
        delete_check_events = "TextChanged",
        -- Display a cursor-like placeholder in unvisited nodes
        -- of the snippet.
        ext_opts = {
          [types.insertNode] = {
            unvisited = {
              virt_text = { { "|", "Conceal" } },
              virt_text_pos = "inline",
            },
          },
          [types.exitNode] = {
            unvisited = {
              virt_text = { { "|", "Conceal" } },
              virt_text_pos = "inline",
            },
          },
          [types.choiceNode] = {
            active = {
              virt_text = { { "(snippet) choice node", "LspInlayHint" } },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local luasnip = require("luasnip")

      ---@diagnostic disable: undefined-field
      luasnip.setup(opts)

      -- Load my custom snippets:
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = vim.fn.stdpath("config") .. "/snippets/",
      })

      -- Use <C-c> to select a choice in a snippet.
      vim.keymap.set({ "i", "s" }, "<C-c>", function()
        if luasnip.choice_active() then
          require("luasnip.extras.select_choice")()
        end
      end, { desc = "Select choice" })
      ---@diagnostic enable: undefined-field
    end,
  },

  -- languages

  { "tpope/vim-rails", ft = { "ruby", "eruby" } },

  { "tpope/vim-bundler", ft = "ruby" },

  { "tpope/vim-rake", ft = "ruby" },

  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    dependencies = "mattn/webapi-vim",
  },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   --dependencies = { "copilotlsp-nvim/copilot-lsp" }, -- Required for NES
  --   config = function()
  --     require("copilot").setup({
  --       nes = { enabled = false }, -- The feature causing the error
  --     })
  --   end,
  -- },

  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        picker = "snacks",
        mux = {
          enabled = true,
          create = "terminal",
        },
      },
      nes = { enabled = false },
    },
    keys = {
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle({ name = "claude", focus = true })
        end,
        desc = "Toggle Claude",
      },
      {
        "<leader>ao",
        function()
          require("sidekick.cli").toggle({ name = "opencode", focus = true })
        end,
        desc = "Toggle Codex",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      {
        "<leader>av",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Send visual selection to Sidekick",
      },
    },
  },
}
