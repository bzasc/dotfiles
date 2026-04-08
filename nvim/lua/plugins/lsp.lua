return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspStart", "LspStop", "LspRestart" },
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      -- LSP Keymaps Setup
      local function setup_keymaps(bufnr)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
        end

        -- Hover & Signature
        map("n", "K", function()
          vim.lsp.buf.hover({ border = "rounded", max_height = 25, max_width = 120 })
        end, "Hover")
        map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Signature Help")

        -- gd, gD, gr, gi, gy handled by Snacks picker (snacks.lua)

        -- Diagnostics navigation
        map("n", "[d", function()
          vim.diagnostic.jump({ count = -1 })
        end, "Prev Diagnostic")
        map("n", "]d", function()
          vim.diagnostic.jump({ count = 1 })
        end, "Next Diagnostic")

        -- <leader>c = Code
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
        map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostic")
        map("n", "<leader>cv", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Definition in Vsplit")

        -- <leader>l = LSP
        map("n", "<leader>li", "<cmd>LspInfo<cr>", "LSP Info")
        map("n", "<leader>lr", "<cmd>LspRestart<cr>", "LSP Restart")
      end

      -- LSP Attach Handler
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          setup_keymaps(bufnr)
          vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Inlay hints disabled by default (toggle with <leader>lh)

          -- Document highlight on cursor hold
          if client.server_capabilities.documentHighlightProvider then
            local group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = bufnr,
              group = group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = bufnr,
              group = group,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- Diagnostic Configuration
      vim.diagnostic.config({
        virtual_text = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = true, header = "", prefix = "" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
          },
        },
      })

      -- SourceKit-LSP (Swift) - not managed by Mason
      --vim.lsp.config("sourcekit", {
      --  cmd = { "sourcekit-lsp" },
      --  filetypes = { "swift", "objc", "objcpp", "c", "cpp" },
      --  root_markers = { "Package.swift", ".git", "compile_commands.json" },
      --  capabilities = {
      --    workspace = {
      --      didChangeWatchedFiles = {
      --        dynamicRegistration = true,
      --      },
      --    },
      --  },
      -- })
      --vim.lsp.enable("sourcekit")
    end,
  },
  {
    "mason-org/mason.nvim",
    lazy = false,
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      local function default_setup(server_name)
        lspconfig[server_name].setup({})
      end

      local handlers = {
        default_setup,

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim", "Snacks" },
                  disable = { "inject-field", "undefined-field", "missing-fields" },
                },
                runtime = { version = "LuaJIT" },
                workspace = {
                  library = { vim.env.VIMRUNTIME },
                  checkThirdParty = false,
                },
                telemetry = { enable = false },
              },
            },
          })
        end,

        ["intelephense"] = function()
          local get_license = function()
            local path = os.getenv("HOME") .. "/intelephense/license.txt"
            local f = io.open(path, "rb")
            if not f then
              return nil
            end
            local content = f:read("*a")
            f:close()
            return string.gsub(content, "%s+", "")
          end
          lspconfig.intelephense.setup({
            cmd = { "intelephense", "--stdio" },
            filetypes = { "php", "blade" },
            root_dir = lspconfig.util.root_pattern("composer.json", ".git"),
            init_options = { licenceKey = get_license() },
          })
        end,
      }

      mason_lspconfig.setup({ handlers = handlers })
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

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "mason-org/mason-lspconfig.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Language Servers
          "lua_ls",
          "gopls",
          "zls",
          "ts_ls",
          "rust-analyzer",
          "intelephense",
          "bashls",
          "cssls",
          "html",
          "jsonls",
          "yamlls",
          "codelldb",
          "ruby-lsp",
          "copilot",
          -- Linters
          "eslint_d",
          "luacheck",
          "golangci-lint",
          "shellcheck",
          "markdownlint",
          "jsonlint",
          "htmlhint",
          "stylelint",
          "phpstan",
          "ruff",
          "mypy",
          "rubocop",
          -- Formatters
          "stylua",
          "goimports",
          "prettier",
          "shfmt",
          "pint",
          "erb-formatter",
        },
      })
    end,
  },
}
