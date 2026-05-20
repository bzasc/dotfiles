return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use

  "christoomey/vim-tmux-navigator", -- tmux & split window navigation

  "preservim/vimux", -- easily interact with tmux from vim

  {
    "szymonwilczek/vim-be-better",
    config = function()
      -- Optional: Enable logging for debugging
      vim.g.vim_be_better_log_file = 1
    end,
  },
}
