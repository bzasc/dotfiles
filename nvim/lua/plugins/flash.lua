vim.pack.add({ "https://github.com/folke/flash.nvim" })

require("flash").setup({
  modes = {
    -- Keep f/t/F/T native.
    char = { enabled = false },
  },
})

vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })
