-- Formatting: Conform.nvim configuration
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  --cmd = { "ConformInfo" },
  config = function()
    local conform = require("conform")
    conform.setup({
      notify_on_error = false,
      notify_no_formatters = false,
      formatters_by_ft = {
        -- Go
        go = { "goimports", "gofmt" },

        -- Lua
        lua = { "stylua" },

        -- Web technologies
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },

        -- Python
        --python = { "isort", "black" },
        python = { "ruff_organise_imports", "ruff_fix", "ruff_format" },

        -- PHP/Laravel
        php = { "pint" },

        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },

        -- Other
        rust = { "rustfmt" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters = {
        ruff_organise_imports = {
          command = "ruff",
          args = {
            "check",
            "--force-exclude",
            "--select=I001",
            "--fix",
            "--exit-zero",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
          stdin = true,
          cwd = require("conform.util").root_file({
            "pyproject.toml",
            "ruff.toml",
            ".ruff.toml",
          }),
        },
      },
    })
    -- Use conform for gq.
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format({
        lsp_format = "fallback",
        async = true,
      })
    end, { desc = "Format file or range" })
  end,
}
