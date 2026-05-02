-- Borrowed from https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/commands.lua

-- Toggle inlay hints
vim.api.nvim_create_user_command("ToggleInlayHints", function()
  vim.g.inlay_hints = not vim.g.inlay_hints
  vim.notify(string.format("%s inlay hints...", vim.g.inlay_hints and "Enabling" or "Disabling"), vim.log.levels.INFO)

  local mode = vim.api.nvim_get_mode().mode
  vim.lsp.inlay_hint.enable(vim.g.inlay_hints and (mode == "n" or mode == "v"))
end, { desc = "Toggle inlay hints", nargs = 0 })

-- Grep TODOs via Snacks picker
vim.api.nvim_create_user_command("Todos", function()
  Snacks.picker.grep({ search = [[TODO:|todo!\(.*\)]], no_esc = true })
end, { desc = "Grep TODOs", nargs = 0 })

-- Scratch buffer
vim.api.nvim_create_user_command("Scratch", function()
  vim.cmd("bel 10new")
  local buf = vim.api.nvim_get_current_buf()
  for name, value in pairs({
    filetype = "scratch",
    buftype = "nofile",
    bufhidden = "wipe",
    swapfile = false,
    modifiable = true,
  }) do
    vim.api.nvim_set_option_value(name, value, { buf = buf })
  end
end, { desc = "Open a scratch buffer", nargs = 0 })
