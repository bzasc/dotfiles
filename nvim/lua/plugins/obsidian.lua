return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- Global keymaps that will lazy-load obsidian.nvim on first use
  keys = {
    { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian Quick Switch" },
    { "<leader>og", "<cmd>Obsidian search<cr>", desc = "Obsidian Search" },
    { "<leader>ot", "<cmd>Obsidian today<cr>", desc = "Obsidian Today" },
    { "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Obsidian Yesterday" },
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "Obsidian New Note" },
    { "<leader>ol", "<cmd>Obsidian follow_link<cr>", desc = "Obsidian Follow Link" },
    { "<leader>oL", "<cmd>Obsidian link_new<cr>", desc = "Obsidian Link New" },
  },

  config = function()
    require("obsidian").setup({
      legacy_commands = false,
      workspaces = {
        {
          name = "bzasc-brain",
          path = vim.env.OBSIDIAN_VAULT or "~/annotations/bzasc_brain",
        },
      },
      notes_subdir = "inbox",
      new_notes_location = "notes_subdir",

      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M:%S",
      },

      daily_notes = {
        folder = "periodic-notes/dailies",
        date_format = "YYYY-MM/YYYY-MM-DD",
        default_tags = { "daily-notes" },
        template = "templates/daily.md",
      },

      completion = {
        blink = true,
        min_chars = 2,
      },
    })
  end,
}
