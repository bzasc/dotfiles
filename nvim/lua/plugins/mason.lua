-- lua/plugins/mason-lsp.lua
-- mason + mason-lspconfig + lspconfig with blink capabilities
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup({})
    local mlsp = require("mason-lspconfig")
    mlsp.setup({
      ensure_installed = {
        "vimls",
        "gopls",
        "rust_analyzer",
        "ts_ls", -- new name; keep fallback to tsserver
        "pyright", -- LSP for python
        "ruff", -- linter & formatter (includes flake8, pep8, black, isort, etc.)
        "taplo", -- LSP for toml (e.g., for pyproject.toml files)
        "ruby_lsp", -- LSP for Ruby
      },
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")
    local blink_caps = require("blink.cmp").get_lsp_capabilities()

    local function enable_inlay_hints(client, buf)
      if client and client.server_capabilities and client.server_capabilities.inlayHintProvider then
        pcall(function()
          vim.lsp.inlay_hint(buf, true)
        end)
      end
    end

    local function on_attach(client, bufnr)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end
      map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
      map("n", "gr", vim.lsp.buf.references, "References")
      map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
      map("n", "K", vim.lsp.buf.hover, "Hover")
      map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")

      enable_inlay_hints(client, bufnr)
    end

    local function with_caps(opts)
      opts = opts or {}
      opts.capabilities = vim.tbl_deep_extend("force", {}, blink_caps, opts.capabilities or {})
      opts.on_attach = on_attach
      return opts
    end

    local servers = {
      gopls = with_caps({
        settings = {
          gopls = {
            usePlaceholders = true,
            analyses = { unusedparams = true },
            staticcheck = true,
          },
        },
      }),
      rust_analyzer = with_caps({
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            check = { command = "clippy" },
          },
        },
      }),
      ruby_lsp = with_caps({}),
      pyright = with_caps({
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoImportCompletions = true,
            },
          },
        },
      }),
      ts_ls = with_caps({}),
    }

    for name, opts in pairs(servers) do
      if lspconfig[name] then
        lspconfig[name].setup(opts)
      end
    end

    vim.diagnostic.config({
      virtual_text = { spacing = 2, prefix = "●" },
      signs = true,
      update_in_insert = false,
      severity_sort = true,
    })
  end,
}
