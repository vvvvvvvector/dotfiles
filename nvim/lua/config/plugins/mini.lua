return {
  {
    "echasnovski/mini.nvim",

    version = false,

    config = function()
      require("mini.cursorword").setup()

      require("mini.ai").setup()

      require("mini.diff").setup()
    end
  },
}
