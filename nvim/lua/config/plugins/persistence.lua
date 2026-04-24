return {
  {
    "folke/persistence.nvim",

    event = "BufReadPre",

    opts = {},

    keys = {
      { "<leader>Ss", function() require("persistence").load() end,                 desc = "Load session" },
      { "<leader>SS", function() require("persistence").select() end,               desc = "Select session" },
      { "<leader>Sl", function() require("persistence").load({ last = true }) end,  desc = "Load last session" },
      { "<leader>Sd", function() require("persistence").stop() end,                 desc = "Stop persistence" },
    },
  }
}
