return {
  {
    "nvim-mini/mini.cursorword",

    version = false,

    config = function()
      require("mini.cursorword").setup()
    end,
  },

  {
    "nvim-mini/mini.ai",

    version = false,

    config = function()
      require("mini.ai").setup()
    end,
  },

  {
    "nvim-mini/mini.diff",

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

  {
    "nvim-mini/mini.bufremove",

    version = false,

    config = function()
      local bufremove = require("mini.bufremove")

      bufremove.setup()

      vim.keymap.set("n", "<leader>br", bufremove.delete, { desc = 'Mini: buf remove' })
    end,
  },

  {
    "nvim-mini/mini.move",

    version = false,

    config = function()
      require("mini.move").setup({
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = '<C-H>',
          right = '<C-L>',
          down = '<C-J>',
          up = '<C-K>',

          -- Move current line in Normal mode
          line_left = '<C-H>',
          line_right = '<C-L>',
          line_down = '<C-J>',
          line_up = '<C-K>',
        },
      })
    end,
  }
}
