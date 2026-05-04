return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signs_staged = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = { interval = 1000, follow_files = true },
        attach_to_untracked = true,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 0,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = function(name, blame_info)
          local icon = "\238\156\165" -- nerd font  (U+E725)
          if not blame_info.author_time or blame_info.author == "Not Committed Yet" then
            return { { "  " .. icon .. " Not Committed Yet", "GitSignsCurrentLineBlame" } }
          end
          local author = blame_info.author == name and "You" or blame_info.author
          local diff = os.difftime(os.time(), tonumber(blame_info.author_time))
          local rel
          if diff < 60 then
            rel = "just now"
          elseif diff < 3600 then
            rel = math.floor(diff / 60) .. "m ago"
          elseif diff < 86400 then
            rel = math.floor(diff / 3600) .. "h ago"
          elseif diff < 2592000 then
            rel = math.floor(diff / 86400) .. "d ago"
          elseif diff < 31536000 then
            rel = math.floor(diff / 2592000) .. "mo ago"
          else
            rel = math.floor(diff / 31536000) .. "y ago"
          end
          return { { "  " .. icon .. " " .. author .. ", " .. rel, "GitSignsCurrentLineBlame" } }
        end,
        sign_priority = 6,
        status_formatter = nil,
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        --on_highlights = function(hl, _)
        --  hl.GitSignsAdd = { fg = "#3b4a3b" }
        --  hl.GitSignsChange = { fg = "#3b3e4b" }
        --  hl.GitSignsDelete = { fg = "#4b3b3b" }
        --  hl.GitSignsUntracked = { fg = "#3b3e4b" }
        --end,
        on_attach = function(bufnr)
          local gs = require("gitsigns")
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          -- Navigation
          map("n", "]h", gs.next_hunk, "Next Hunk")
          map("n", "[h", gs.prev_hunk, "Prev Hunk")
        end,
      })
    end,
    keys = {
      -- Hunk operations under <leader>gh (git hunk)
      {
        "<leader>ghp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview Hunk",
      },
      {
        "<leader>ghP",
        function()
          require("gitsigns").preview_hunk_inline()
        end,
        desc = "Preview Hunk Inline",
      },
      {
        "<leader>ghs",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Stage Hunk",
      },
      {
        "<leader>ghu",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "Undo Stage Hunk",
      },
      {
        "<leader>ghr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset Hunk",
      },
      -- Buffer operations
      {
        "<leader>gR",
        function()
          require("gitsigns").reset_buffer()
        end,
        desc = "Reset Buffer",
      },
      {
        "<leader>ghS",
        function()
          require("gitsigns").stage_buffer()
        end,
        desc = "Stage Buffer",
      },
      -- Blame
      {
        "<leader>gb",
        function()
          require("gitsigns").blame_line()
        end,
        desc = "Blame Line",
      },
      {
        "<leader>gB",
        function()
          require("gitsigns").blame()
        end,
        desc = "Blame Buffer",
      },
      -- Diff
      {
        "<leader>gD",
        function()
          vim.cmd("Gitsigns diffthis HEAD")
        end,
        desc = "Diff HEAD",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  },
}
