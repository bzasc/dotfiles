-- LSP
local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

local default_keymaps = {
  { keys = "<leader>ca", func = vim.lsp.buf.code_action, desc = "Code Actions" },
  {
    keys = "<leader>cl",
    func = function()
      if vim.fn.exists(":LspOxlintFixAll") > 0 then
        vim.cmd("LspOxlintFixAll")
      elseif vim.fn.exists(":LspEslintFixAll") > 0 then
        vim.cmd("LspEslintFixAll")
      else
        vim.lsp.buf.code_action({
          apply = true,
          context = { only = { "source.fixAll" }, diagnostics = {} },
        })
      end
    end,
    desc = "LSP Fix All",
  },
  { keys = "<leader>cr", func = vim.lsp.buf.rename, desc = "Code Rename" },
  { keys = "<leader>k", func = vim.lsp.buf.hover, desc = "Hover Documentation", has = "hoverProvider" },
  { keys = "K", func = vim.lsp.buf.hover, desc = "Hover (alt)", has = "hoverProvider" },
  { keys = "gd", func = vim.lsp.buf.definition, desc = "Goto Definition", has = "definitionProvider" },
  { keys = "grt", func = vim.lsp.buf.type_definition, desc = "Goto Type Definition", has = "typeDefinitionProvider" },
  { keys = "grx", func = vim.lsp.codelens.run, desc = "Run Codelens", has = "codeLensProvider" },
  { keys = "<leader>cw", func = vim.lsp.buf.workspace_diagnostics, desc = "Workspace Diagnostics" },
}

local completion = vim.g.completion_mode or "blink" -- or 'native'
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_attach"),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf
    if client then
      -- Built-in completion
      if completion == "native" and client:supports_method("textDocument/completion") then
        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      end

      if client:supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = buf })

        if not vim.b[buf].inlay_hints_autocmd_set then
          vim.api.nvim_create_autocmd("InsertEnter", {
            buffer = buf,
            callback = function()
              vim.lsp.inlay_hint.enable(false, { bufnr = buf })
            end,
          })
          vim.api.nvim_create_autocmd("InsertLeave", {
            buffer = buf,
            callback = function()
              vim.lsp.inlay_hint.enable(true, { bufnr = buf })
            end,
          })
          vim.b[buf].inlay_hints_autocmd_set = true
        end
      end

      if client:supports_method("textDocument/documentColor") then
        vim.lsp.document_color.enable(true, { bufnr = buf }, {
          style = "virtual",
        })
      end

      if client.name == "ruff" then
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end

      if client.name == "ruby_lsp" then
        client.server_capabilities.semanticTokensProvider = nil
        client.server_capabilities.documentHighlightProvider = nil
      end

      for _, km in ipairs(default_keymaps) do
        -- Only bind if there's no `has` requirement, or the server supports it
        if not km.has or client.server_capabilities[km.has] then
          vim.keymap.set(
            km.mode or "n",
            km.keys,
            km.func,
            { buffer = buf, desc = "LSP: " .. km.desc, nowait = km.nowait }
          )
        end
      end
    end
  end,
})

local ts_server = vim.g.lsp_typescript_server or "vtsls"

local servers_by_ft = {
  lua = { "lua_ls" },
  python = { "ruff", "pyreply" },
  ruby = { "ruby_lsp" },
  javascript = { ts_server, "oxlint", "eslint" },
  javascriptreact = { ts_server, "oxlint", "eslint", "tailwindcss" },
  typescript = { ts_server, "oxlint", "eslint" },
  typescriptreact = { ts_server, "oxlint", "eslint", "tailwindcss" },
  vue = { ts_server, "tailwindcss" },
  svelte = { ts_server, "tailwindcss" },
  html = { "html", "tailwindcss" },
  css = { "cssls", "tailwindcss" },
  scss = { "cssls", "tailwindcss" },
  less = { "cssls" },
  sh = { "bashls" },
  bash = { "bashls" },
  json = { "jsonls" },
  jsonc = { "jsonls" },
  yaml = { "yamlls" },
  rust = { "rust_analyzer" },
  zig = { "zls" },
}

local enabled = {}
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("lsp_lazy_enable"),
  callback = function(ev)
    local servers = servers_by_ft[ev.match]
    if not servers then
      return
    end
    for _, name in ipairs(servers) do
      if not enabled[name] then
        enabled[name] = true
        vim.lsp.enable(name)
      end
    end
  end,
})

if vim.g.lsp_on_demands then
  vim.lsp.enable(vim.g.lsp_on_demands)
end
