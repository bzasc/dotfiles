return {
  "nvim-tree/nvim-web-devicons",
  commit = "313d9e7193354c5de7cdb1724f9e2d3f442780b0",
  config = function()
    require("nvim-web-devicons").set_icon({
      gql = {
        icon = "",
        color = "#e535ab",
        cterm_color = "199",
        name = "GraphQL",
      },
    })
  end,
}
