return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup {
      columns = { "icon" },
      keymaps = {
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
      },
      view_options = {
        show_hidden = true,
        natural_order = true,
      },
    }

    -- Open parent directory in current window
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

    -- Open parent directory in floating window
    vim.keymap.set("n", "<space>-", require("oil").toggle_float)
  end,
}
