vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/obsidian-nvim/obsidian.nvim",
})

local obsidian_vault = vim.env.HOME .. "/annotations/bzasc_brain"
local _obsidian_initialized = false

local function init_obsidian()
  if _obsidian_initialized then
    return
  end
  _obsidian_initialized = true

  require("obsidian").setup({
    legacy_commands = false,
    ui = { enable = false },
    picker = { name = "snacks.picker" },
    workspaces = {
      { name = "bzasc-brain", path = vim.env.OBSIDIAN_VAULT or "~/annotations/bzasc_brain" },
    },
    notes_subdir = "raw",
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
    completion = { blink = true, min_chars = 2 },
  })
end

-- Auto-init when entering a markdown buffer so :Obsidian* commands work without a keymap
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  once = true,
  callback = init_obsidian,
})

local function obs_cmd(cmd)
  return function()
    init_obsidian()
    vim.cmd(cmd)
  end
end

-- Original Obsidian commands
vim.keymap.set("n", "<leader>oq", obs_cmd("Obsidian quick_switch"), { desc = "Obsidian Quick Switch" })
vim.keymap.set("n", "<leader>og", obs_cmd("Obsidian search"), { desc = "Obsidian Search" })
vim.keymap.set("n", "<leader>ot", obs_cmd("Obsidian today"), { desc = "Obsidian Today" })
vim.keymap.set("n", "<leader>oy", obs_cmd("Obsidian yesterday"), { desc = "Obsidian Yesterday" })
vim.keymap.set("n", "<leader>on", obs_cmd("Obsidian new"), { desc = "Obsidian New Note" })
vim.keymap.set("n", "<leader>ol", obs_cmd("Obsidian follow_link"), { desc = "Obsidian Follow Link" })
vim.keymap.set("n", "<leader>oL", obs_cmd("Obsidian link_new"), { desc = "Obsidian Link New" })

-- Custom templates
vim.keymap.set("n", "<leader>oN", function()
  init_obsidian()
  vim.cmd("Obsidian template note")
end, { desc = "Add note Obsidian template" })

vim.keymap.set("n", "<leader>oc", function()
  init_obsidian()
  vim.cmd("Obsidian template class-note")
end, { desc = "Add class-note Obsidian template" })

vim.keymap.set("n", "<leader>od", function()
  init_obsidian()
  vim.cmd("Obsidian template daily")
end, { desc = "Add daily Obsidian template" })

vim.keymap.set("n", "<leader>oh", function()
  init_obsidian()
  vim.cmd("Obsidian template habits")
end, { desc = "Add Habits Obsidian template" })

-- Vault pickers (Snacks only — no obsidian setup needed)
vim.keymap.set("n", "<leader>os", function()
  Snacks.picker.files({ cwd = obsidian_vault })
end, { desc = "Locate files in Obsidian vault" })

vim.keymap.set("n", "<leader>oz", function()
  Snacks.picker.live_grep({ cwd = obsidian_vault })
end, { desc = "Ripgrep in Obsidian vault" })
