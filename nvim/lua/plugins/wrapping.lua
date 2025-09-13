return {
  "andrewferrier/wrapping.nvim",
  opts = {
    notify_on_switch = false,
  },
  config = function()
    require("wrapping").setup()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      command = "SoftWrapMode",
    })
  end,
}
