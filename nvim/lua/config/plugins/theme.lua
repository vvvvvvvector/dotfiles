return {
  {
    "catppuccin/nvim",

    name = "catppuccin",

    -- priority = 1000,
    --
    -- -- optionally set the colorscheme within lazy config
    -- init = function()
    --   vim.cmd("colorscheme catppuccin-mocha")
    -- end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    -- config = function()
    --   vim.cmd("colorscheme rose-pine")
    -- end
  },
  {
    "rebelot/kanagawa.nvim"
  },
  {
    "gmr458/cold.nvim",
  },
  {
    "vague2k/vague.nvim",
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup({
        -- optional configuration here
      })
    end
  }
}
