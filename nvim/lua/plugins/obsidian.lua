return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  -- Allow lazy-loading the plugin when these commands are invoked
  cmd = {
    "ObsidianQuickSwitch",
    "ObsidianSearch",
    "ObsidianToday",
    "ObsidianYesterday",
    "ObsidianNew",
    "ObsidianLink",
    "ObsidianLinkNew",
    "ObsidianTemplate",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- Global keymaps that will lazy-load obsidian.nvim on first use
  keys = {
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian Quick Switch" },
    { "<leader>og", "<cmd>ObsidianSearch<cr>", desc = "Obsidian Search" },
    { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Obsidian Today" },
    { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Obsidian Yesterday" },
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "Obsidian New Note" },
    { "<leader>ol", "<cmd>ObsidianFollowLink<cr>", desc = "Obsidian Follow Link" },
    { "<leader>oL", "<cmd>ObsidianLinkNew<cr>", desc = "Obsidian Link New" },
  },

  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "bzasc-brain",
          path = vim.env.OBSIDIAN_VAULT or "/home/bzasc/annotations/bzasc_brain",
        },
      },
      notes_subdir = "inbox",
      new_notes_location = "notes_subdir",

      disable_frontmatter = true,
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M:%S",
      },

      -- key mappings, below are the defaults
      mappings = {
        -- overrides the 'gf' mapping to work on markdown/wiki links within your vault
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
      },
      completion = {
        blink = true,
        min_chars = 2,
      },
      ui = {
        -- Disable some things below here because I set these manually for all Markdown files using treesitter
        checkboxes = {},
        bullets = {},
        enable = false,
      },
    })
  end,
}
