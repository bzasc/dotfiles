---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    { ".luarc.json", ".luarc.jsonc", ".luacheckrc" },
    { ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml" },
    ".git",
  },
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
}
