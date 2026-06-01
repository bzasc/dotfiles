vim.pack.add({ "https://github.com/folke/sidekick.nvim" })

local sidekick = require("sidekick")

sidekick.setup({
  nes = {
    enabled = false,
  },
  cli = {
    mux = {
      backend = "tmux",
      enabled = true,
      create = "split", -- new tmux split pane (outside nvim), opened at nvim's cwd
    },
  },
})

local cli = require("sidekick.cli")

-- Toggle & navigation
vim.keymap.set("n", "<leader>aa", function()
  cli.toggle({ name = "claude", focus = true })
end, { desc = "Toggle Claude" })
vim.keymap.set("n", "<leader>as", function()
  cli.select({ filter = { installed = true } })
end, { desc = "AI select CLI" })
vim.keymap.set({ "n", "x", "i", "t" }, "<c-,>", cli.focus, { desc = "AI switch focus" })
vim.keymap.set({ "n", "x" }, "<leader>ap", cli.prompt, { desc = "AI select prompt" })

-- Send context
vim.keymap.set({ "n", "x" }, "<leader>al", function()
  cli.send({ msg = "{line}" })
end, { desc = "AI send line" })
vim.keymap.set("x", "<leader>av", function()
  cli.send({ msg = "{selection}" })
end, { desc = "AI send selection" })
vim.keymap.set({ "n", "x" }, "<leader>af", function()
  cli.send({ msg = "{function}" })
end, { desc = "AI send function" })
vim.keymap.set({ "n", "x" }, "<leader>ac", function()
  cli.send({ msg = "{class}" })
end, { desc = "AI send class" })
vim.keymap.set({ "n", "x" }, "<leader>at", function()
  cli.send({ msg = "{this}" })
end, { desc = "AI send this" })
vim.keymap.set({ "n", "x" }, "<leader>ab", function()
  cli.send({ msg = "{file}" })
end, { desc = "AI send buffer" })
vim.keymap.set({ "n", "x" }, "<leader>ad", function()
  cli.send({ msg = "{diagnostics}" })
end, { desc = "AI send diagnostics" })
vim.keymap.set({ "n", "x" }, "<leader>aq", function()
  cli.send({ msg = "{quickfix}" })
end, { desc = "AI send quickfix" })
vim.keymap.set("n", "<leader>aD", function()
  cli.close()
end, { desc = "AI detach CLI session" })

local sidekick_exit_group = vim.api.nvim_create_augroup("SidekickCloseOnExit", { clear = true })

local function is_sidekick_win(win)
  return vim.api.nvim_win_is_valid(win) and vim.w[win].sidekick_cli ~= nil
end

local function regular_wins()
  local wins = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "" and not is_sidekick_win(win) then
      wins[#wins + 1] = win
    end
  end
  return wins
end

-- Close Sidekick's window synchronously before quitting the last regular window.
vim.api.nvim_create_autocmd("QuitPre", {
  group = sidekick_exit_group,
  callback = function()
    pcall(function()
      local wins = regular_wins()
      if #wins ~= 1 then
        return
      end

      if is_sidekick_win(vim.api.nvim_get_current_win()) then
        vim.api.nvim_set_current_win(wins[1])
      end

      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if is_sidekick_win(win) then
          pcall(vim.api.nvim_win_close, win, true)
        end
      end
    end)
  end,
})

-- Kill sidekick tmux panes on exit so they don't linger.
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = sidekick_exit_group,
  callback = function()
    pcall(function()
      cli.close()
    end)
  end,
})
