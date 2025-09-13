return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<leader>sf", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "<leader>sF", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "<leader>sr", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "<leader>sR", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>",     mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
}
