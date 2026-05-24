---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", "init.lua", ".git" },
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
      diagnostics = {
        globals = { "vim", "Snacks" },
        disable = { "inject-field", "undefined-field", "missing-fields" },
      },
      -- Using stylua for formatting.
      format = { enable = false },
      hint = {
        enable = false,
        arrayIndex = "Disable",
      },
      runtime = { version = "LuaJIT" },
      workspace = { checkThirdParty = false },
    },
  },
}
