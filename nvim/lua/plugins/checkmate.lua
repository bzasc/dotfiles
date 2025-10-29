return {
  "bngarren/checkmate.nvim",
  ft = "markdown",
  opts = {
    files = {
      "*.md", -- Any markdown file (basename matching)
      "**/todo.md", -- 'todo.md' anywhere in directory tree
    },
  },
}
