vim.pack.add({
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/folke/noice.nvim",
})

require("noice").setup({
  -- Snacks.notifier owns vim.notify (history on <leader>n, dismiss on <leader>un);
  -- noice taking it over left both of those empty.
  notify = { enabled = false },
  lsp = {
    -- fidget handles progress, blink handles signature help,
    -- and config/lsp.lua wraps hover with its own size caps.
    progress = { enabled = false },
    signature = { enabled = false },
    hover = { enabled = false },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
  },
  presets = {
    long_message_to_split = true,
  },
  views = {
    cmdline_popup = {
      position = { row = "50%", col = "50%" },
      --border = { style = "none", padding = { 0, 1 } },
    },
    --popupmenu = { border = { style = "none", padding = { 0, 1 } } },
  },
})
