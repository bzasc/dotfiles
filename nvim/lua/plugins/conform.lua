return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  config = function()
    local conform = require("conform")
    conform.setup({
      -- Leave me alone.
      notify_on_error = false,
      notify_no_formatters = false,
      formatters_by_ft = {
        html = { "prettier" },
        c = { name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
        go = { name = "gopls", timeout_ms = 500, lsp_format = "prefer" },
        javascript = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
        javascriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
        json = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
        jsonc = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
        less = { "prettier" },
        markdown = { "prettier" },
        --rust = { name = "rust_analyzer", timeout_ms = 500, lsp_format = "prefer" },
        rust = { "rustfmt", lsp_format = "fallback" },
        scss = { "prettier" },
        sh = { "shfmt" },
        typescript = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
        typescriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
        yaml = { "prettier" },
        lua = { "stylua" },
        ruby = { "rubocop" },
        python = { "ruff_organise_imports", "ruff_fix", "ruff_format" },
        eruby = { "erb_format" },
        erb = { "erb_format" },
        -- For filetypes without a formatter:
        ["_"] = { "trim_whitespace", "trim_newlines" },
      },
      format_on_save = function()
        -- Don't format when minifiles is open, since that triggers the "confirm without
        -- synchronization" message.
        if vim.g.minifiles_active then
          return nil
        end

        -- Skip formatting if triggered from my special save command.
        if vim.g.skip_formatting then
          vim.g.skip_formatting = false
          return nil
        end

        -- Stop if we disabled auto-formatting.
        if not vim.g.autoformat then
          return nil
        end

        return {}
      end,
      -- (formatexpr is set below, outside setup)
      formatters = {
        dprint = {
          condition = function(_, ctx)
            return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
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
