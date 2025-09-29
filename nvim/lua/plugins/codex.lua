return {
  {
    "johnseth97/codex.nvim",
    lazy = true,
    cmd = { "Codex", "CodexToggle" },
    keys = {
      {
        "<leader>cc",
        function()
          require("codex").toggle()
        end,
        desc = "Toggle Codex",
      },
    },
    opts = {
      autoinstall = true,
      border = "rounded",
      width = 0.8,
      height = 0.8,
      model = "gpt-5-high",
    },
  },
}
