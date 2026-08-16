-- LSP
local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd("checkhealth vim.lsp")
end, { desc = "Show builtin LSP health information" })

vim.api.nvim_create_user_command("LspRestart", function(opts)
  local args = opts.args ~= "" and (" " .. opts.args) or ""
  vim.cmd("lsp restart" .. args)
end, { desc = "Restart builtin LSP clients", nargs = "*" })

vim.api.nvim_create_user_command("LspStop", function(opts)
  local args = opts.args ~= "" and (" " .. opts.args) or ""
  vim.cmd("lsp stop" .. args)
end, { desc = "Stop builtin LSP clients", nargs = "*" })

vim.api.nvim_create_user_command("LspStart", function()
  vim.cmd("edit")
end, { desc = "Retry attaching builtin LSP for the current buffer" })

-- Cap hover/signature float size so large docs don't fill the screen.
local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
  return hover({
    max_height = math.floor(vim.o.lines * 0.5),
    max_width = math.floor(vim.o.columns * 0.4),
    border = "rounded",
  })
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
  {
    keys = "<leader>uh",
    func = function()
      local buf = vim.api.nvim_get_current_buf()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
    end,
    desc = "Toggle Inlay Hints",
    has = "inlayHintProvider",
  },
  { keys = "<leader>k", func = vim.lsp.buf.hover, desc = "Hover Documentation", has = "hoverProvider" },
  { keys = "K", func = vim.lsp.buf.hover, desc = "Hover (alt)", has = "hoverProvider" },
  -- Goto definition / type-definition owned by Snacks pickers (gd, gy in snacks.lua).
  { keys = "grx", func = vim.lsp.codelens.run, desc = "Run Codelens", has = "codeLensProvider" },
  {
    keys = "<leader>cw",
    func = function()
      vim.diagnostic.setqflist()
    end,
    desc = "Workspace Diagnostics (quickfix)",
  },
  { keys = "<leader>li", func = "<cmd>LspInfo<cr>", desc = "LSP Info" },
  { keys = "<leader>lr", func = "<cmd>LspRestart<cr>", desc = "LSP Restart" },
}

local completion = vim.g.completion_mode or "native" -- or 'native'

-- Servers whose inlay hints we never want, regardless of capability.
-- pyrefly only emits inferred-type hints (`x: str`) and ignores its own
-- `python.pyrefly.inlayHints` settings, so it has to be filtered here.
-- <leader>uh still works to turn them on ad hoc for a buffer.
local no_inlay_hints = {
  pyrefly = true,
}

local function on_attach(client, buf)
  if client then
    -- Built-in completion
    if completion == "native" and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
    end

    if client:supports_method("textDocument/documentColor") then
      vim.lsp.document_color.enable(true, { bufnr = buf }, {
        style = "virtual",
      })
    end

    -- Inlay hints. Servers curate what they send (see lsp/vtsls.lua,
    -- lsp/rust_analyzer.lua; lua_ls opts out via hint.enable=false).
    -- Set `vim.g.inlay_hints = false` to opt out globally, or <leader>uh
    -- to toggle the current buffer.
    if
      vim.g.inlay_hints ~= false
      and not no_inlay_hints[client.name]
      and client:supports_method("textDocument/inlayHint")
    then
      vim.lsp.inlay_hint.enable(true, { bufnr = buf })
    end

    -- Codelens defaults to off per-buffer, so `grx` had nothing to run.
    -- enable() owns its own debounced refresh (nvim 0.12 capability
    -- framework) — no manual refresh autocmd needed.
    if client:supports_method("textDocument/codeLens") then
      vim.lsp.codelens.enable(true, { bufnr = buf })
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
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_attach"),
  callback = function(args)
    on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
  end,
})

-- Re-run on_attach when a client registers capabilities dynamically (after
-- initial attach), so late-registered methods still get their keymaps.
local register_capability = vim.lsp.handlers["client/registerCapability"]
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local buf = vim.api.nvim_get_current_buf()
  -- Only re-attach when this client is actually on the current buffer, else
  -- feature enables (inlay hints, document color) fire on the wrong buffer.
  if client and vim.lsp.buf_is_attached(buf, client.id) then
    on_attach(client, buf)
  end
  return register_capability(err, res, ctx)
end

local ts_server = vim.g.lsp_typescript_server or "vtsls"

-- This table is the ONLY gate for starting a server: a filetype listed in an
-- lsp/*.lua `filetypes` but missing here will never attach.
local servers_by_ft = {
  lua = { "lua_ls" },
  -- pyrefly covers definition/refs/hover/inlayHint (and adds codeLens +
  -- foldingRange), so basedpyright was redundant here; ruff owns lint +
  -- organizeImports.
  python = { "pyrefly", "ruff" },
  ruby = { "ruby_lsp" },
  eruby = { "tailwindcss" },
  javascript = { ts_server, "oxlint", "eslint" },
  javascriptreact = { ts_server, "oxlint", "eslint", "tailwindcss" },
  typescript = { ts_server, "oxlint", "eslint" },
  typescriptreact = { ts_server, "oxlint", "eslint", "tailwindcss" },
  vue = { ts_server, "tailwindcss" },
  svelte = { ts_server, "tailwindcss" },
  astro = { "oxlint", "eslint", "tailwindcss" },
  html = { "html", "tailwindcss" },
  htmlangular = { "eslint", "tailwindcss" },
  css = { "cssls", "tailwindcss" },
  scss = { "cssls", "tailwindcss" },
  less = { "cssls" },
  sh = { "bashls" },
  bash = { "bashls" },
  zsh = { "bashls" },
  json = { "jsonls" },
  jsonc = { "jsonls" },
  yaml = { "yamlls" },
  rust = { "rust_analyzer" },
  zig = { "zls" },
  zir = { "zls" },
  dockerfile = { "docker_language_server" },
  ["yaml.docker-compose"] = { "docker_language_server" },
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
