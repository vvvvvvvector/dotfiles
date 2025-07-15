return {
  "folke/flash.nvim",

  event = "VeryLazy",

  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        enabled = true,
      },
      char = {
        jump_labels = false,
      },
    },
  },
  -- n - normal mode
  -- o - operator pending mode
  -- v - visual mode
  -- c - command line mode
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
}
