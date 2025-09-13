-- Fuzzy finder
return {
  -- https://github.com/nvim-telescope/telescope.nvim
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Fuzzy find files in cwd" },
    { "<leader>fr", function() require("telescope.builtin").oldfiles() end,    desc = "Fuzzy find recent files" },
    { "<leader>fs", function() require("telescope.builtin").live_grep() end,   desc = "Find string in cwd" },
    { "<leader>fc", function() require("telescope.builtin").grep_string() end, desc = "Find string under cursor in cwd" },
    { "<leader>fg", function() require("telescope.builtin").git_files() end,   desc = "Find git files" },
    { "<leader>/",  function()
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, desc = "[/] Fuzzily search in current buffer" },
    { "<leader>f/", function()
        require("telescope.builtin").live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
      end, desc = "[S]earch [/] in Open Files" },
    { "<leader>fn", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, desc = "[S]earch [N]eovim files" },
  },
  dependencies = {
    -- https://github.com/nvim-lua/plenary.nvim
    { "nvim-lua/plenary.nvim" },
    {
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-x>"] = actions.delete_buffer,
          },
        },
        file_ignore_patterns = {
          "node_modules",
          "yarn.lock",
          ".git",
          ".sl",
          "_build",
          ".next",
        },
        hidden = true,
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")

    -- keymaps moved to `keys` for lazy-loading on demand
  end,
}
