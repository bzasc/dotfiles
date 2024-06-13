return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    local harpoon = require("harpoon")

    harpoon:setup({
      settings = {
        save_on_toggle = true,
      },
    })

    keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
    keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
    keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
    keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
    keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)
  end,
}
