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
