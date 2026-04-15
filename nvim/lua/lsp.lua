local function del(mode, lhs)
  pcall(vim.keymap.del, mode, lhs)
end

local function create_compat_commands()
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
end

local function setup_keymaps(bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
  end

  local function snacks_picker(method, fallback)
    return function()
      local ok, result = pcall(function()
        return Snacks.picker[method]()
      end)
      if not ok and fallback then
        fallback()
      end
      return result
    end
  end

  map("n", "K", function()
    vim.lsp.buf.hover({ border = "rounded", max_height = 25, max_width = 120 })
  end, "Hover")
  map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")

  map("n", "gd", vim.lsp.buf.definition, "Definition")
  map("n", "gD", vim.lsp.buf.declaration, "Declaration")
  map("n", "gr", snacks_picker("lsp_references", vim.lsp.buf.references), "References")
  map("n", "gi", snacks_picker("lsp_implementations", vim.lsp.buf.implementation), "Implementation")
  map("n", "gy", snacks_picker("lsp_type_definitions", vim.lsp.buf.type_definition), "Type Definition")

  map("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
  end, "Prev Diagnostic")
  map("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
  end, "Next Diagnostic")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("n", "<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
  map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostic")
  map("n", "<leader>cv", function()
    vim.cmd("vsplit")
    vim.lsp.buf.definition()
  end, "Definition in Vsplit")

  map("n", "<leader>li", "<cmd>LspInfo<cr>", "LSP Info")
  map("n", "<leader>lr", "<cmd>LspRestart<cr>", "LSP Restart")
end

local group = vim.api.nvim_create_augroup("bzasc/native_lsp", { clear = true })
local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_blink, blink = pcall(require, "blink.cmp")

if capabilities.workspace then
  capabilities.workspace.didChangeWatchedFiles = nil
end

if capabilities.textDocument then
  capabilities.textDocument.diagnostic = nil
end

if has_blink then
  capabilities = blink.get_lsp_capabilities(capabilities)
  if capabilities.textDocument then
    capabilities.textDocument.diagnostic = nil
  end
end

-- Keep the current surface area stable by removing builtin global defaults.
del({ "n", "x" }, "gra")
del("n", "gri")
del("n", "grn")
del("n", "grr")
del("n", "grt")
del("n", "grx")
del("n", "gO")
del("i", "<C-s>")

create_compat_commands()

vim.lsp.config("*", {
  capabilities = capabilities,
})

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

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    setup_keymaps(bufnr)
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    if client.server_capabilities.documentHighlightProvider then
      local highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        group = highlight_group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = bufnr,
        group = highlight_group,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

for _, name in ipairs({
  "lua_ls",
  "gopls",
  "zls",
  "ts_ls",
  "ruff",
  "pyright",
  "intelephense",
  "bashls",
  "cssls",
  "html",
  "jsonls",
  "yamlls",
  "ruby_lsp",
}) do
  vim.lsp.enable(name)
end
