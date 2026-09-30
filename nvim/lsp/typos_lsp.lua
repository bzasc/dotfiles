-- Source-code spell checker. Enabled for every filetype from config/lsp.lua
-- (outside `servers_by_ft`). Picks up a project's typos.toml / _typos.toml /
-- .typos.toml automatically.
---@type vim.lsp.Config
return {
  cmd = { "typos-lsp" },
  -- Logs appear in :LspLog.
  cmd_env = { RUST_LOG = "typos_lsp=error" },
  init_options = {
    -- Error, Warning, Info or Hint.
    diagnosticSeverity = "Info",
  },
}
