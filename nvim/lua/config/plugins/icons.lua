return {
  "nvim-tree/nvim-web-devicons",

  config = function()
    require 'nvim-web-devicons'.setup({
      override_by_extension = {
        ["css"] = {
          icon = "",
          color = "#3b82f6",
          name = "css"
        },

        ["tsx"] = {
          icon = "",
          color = "#58C4DC",
          name = "tsx"
        }
      },
    })
  end
}
