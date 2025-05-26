return {
  {
    "echasnovski/mini.cursorword",

    version = false,

    config = function()
      require("mini.cursorword").setup()
    end,
  },

  {
    "echasnovski/mini.ai",

    version = false,

    config = function()
      require("mini.ai").setup()
    end,
  },

  {
    "echasnovski/mini.diff",

    version = false,

    config = function()
      require("mini.diff").setup({
        view = {
          style = "number"
        },
        mapping = {
          goto_first = "[H",
          goto_prev = "",
          goto_next = "",
          goto_last = "]H",
        }
      })

      vim.keymap.set("n", "<leader>do", "<cmd>lua MiniDiff.toggle_overlay()<cr>", { desc = "MiniDiff toggle overlay" })
      vim.keymap.set("n", "[h", "<cmd>lua MiniDiff.goto_hunk('prev')<cr>zz", { desc = "MiniDiff prev hunk" })
      vim.keymap.set("n", "]h", "<cmd>lua MiniDiff.goto_hunk('next')<cr>zz", { desc = "MiniDiff next hunk" })
    end,
  },
}
