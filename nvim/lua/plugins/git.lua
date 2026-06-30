vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/sindrets/diffview.nvim",
})

-- Setup gitsigns.nvim
require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 800,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = "<author>, <author_time:%R> - <summary> (<abbrev_sha>)",
  on_attach = function(buffer)
    local gs = package.loaded.gitsigns

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
    end

    map("n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end, "Next Hunk")

    map("n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gs.nav_hunk("prev")
      end
    end, "Prev Hunk")

    map("n", "]H", function()
      gs.nav_hunk("last")
    end, "Last Hunk")
    map("n", "[H", function()
      gs.nav_hunk("first")
    end, "First Hunk")

    map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
    map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")

    map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
    map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
    map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
    map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
    map("n", "<leader>ghb", function()
      gs.blame_line({ full = true })
    end, "Blame Line")
    map("n", "<leader>ghB", function()
      gs.blame()
    end, "Blame Buffer")
    map("n", "<leader>ghd", gs.diffthis, "Diff This")
    map("n", "<leader>ghD", function()
      gs.diffthis("~")
    end, "Diff This ~")

    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
  end,
})

-- Setup diffview.nvim
require("diffview").setup({})

-- Quick shortcuts for common comparisons
vim.keymap.set("n", "<leader>Do", "<Cmd>DiffviewOpen<CR>", { desc = "Diff: working tree (all files)" })
vim.keymap.set("n", "<leader>Ds", "<Cmd>DiffviewOpen --staged<CR>", { desc = "Diff: staged (all files)" })

-- Accepts any ref: branch, commit, tag, HEAD~N, or empty for working tree
vim.keymap.set("n", "<leader>Dr", function()
  vim.ui.input({
    prompt = "Diff against (branch/commit/tag/HEAD~N, empty=working): ",
  }, function(ref)
    vim.cmd("DiffviewOpen " .. (ref or ""))
  end)
end, { desc = "Diff: against ref" })

-- COMPARE TWO REFS (e.g., branches, commits, tags)
vim.keymap.set("n", "<leader>DR", function()
  vim.ui.input({ prompt = "Diff ref1 (default=HEAD): " }, function(ref1)
    if not ref1 or ref1 == "" then
      ref1 = "HEAD"
    end
    vim.ui.input({ prompt = "Diff ref2: " }, function(ref2)
      if ref2 and ref2 ~= "" then
        vim.cmd("DiffviewOpen " .. ref1 .. ".." .. ref2)
      end
    end)
  end)
end, { desc = "Diff: two refs" })

-- FILE / LINE HISTORY (diffview shows merge conflicts as a 3-way view automatically on DiffviewOpen)
vim.keymap.set("n", "<leader>Dh", "<Cmd>DiffviewFileHistory %<CR>", { desc = "Diff: file history" })
vim.keymap.set("v", "<leader>Dh", ":'<,'>DiffviewFileHistory<CR>", { desc = "Diff: line history" })
vim.keymap.set("n", "<leader>DH", "<Cmd>DiffviewFileHistory<CR>", { desc = "Diff: repo history" })

vim.keymap.set("n", "<leader>Dt", "<Cmd>DiffviewToggleFiles<CR>", { desc = "Diff: toggle file panel" })
vim.keymap.set("n", "<leader>Dc", "<Cmd>DiffviewClose<CR>", { desc = "Diff: close" })

-- UTILITY: Compare two arbitrary files with difftastic (or vimdiff fallback)
vim.keymap.set("n", "<leader>g2", function()
  vim.ui.input({ prompt = "First file: " }, function(file1)
    if not file1 or not file1:match("%S") then
      return
    end
    vim.ui.input({ prompt = "Second file: " }, function(file2)
      if file2 and file2:match("%S") then
        local abs1 = vim.fn.fnamemodify(file1, ":p")
        local abs2 = vim.fn.fnamemodify(file2, ":p")
        if vim.fn.executable("difft") == 1 then
          vim.cmd("tabnew | terminal difft " .. abs1 .. " " .. abs2)
        else
          vim.cmd(("tabnew | e %s | diffthis | vsplit %s | diffthis"):format(abs1, abs2))
        end
      end
    end)
  end)
end, { desc = "Git: compare 2 files (difftastic or vimdiff)" })
