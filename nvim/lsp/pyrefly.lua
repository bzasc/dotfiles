---@type vim.lsp.Config
return {
  cmd = { "pyrefly", "lsp" },
  filetypes = { "python" },
  root_markers = {
    "pyrefly.toml",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".git",
  },
  -- NOTE: pyrefly 1.0.0 ignores `python.pyrefly.inlayHints`
  -- (variableTypes/functionReturnTypes/callArgumentNames). Verified via
  -- lsp.log: the settings are delivered on both didChangeConfiguration and
  -- workspace/configuration, and it still answers textDocument/inlayHint with
  -- the type hints. So the hints are suppressed client-side instead — see
  -- `no_inlay_hints` in config/lsp.lua.
  on_exit = function(code, _, _)
    vim.schedule(function()
      vim.notify("Closing Pyrefly LSP exited with code: " .. code, vim.log.levels.INFO)
    end)
  end,
}
