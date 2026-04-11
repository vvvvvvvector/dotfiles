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
      require("mini.ai").setup({
        -- Table with textobject id as fields, textobject specification as values.
        -- Also use this to disable builtin textobjects. See |MiniAi.config|.
        custom_textobjects = nil,

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Main textobject prefixes
          around = 'a',
          inside = 'i',

          -- Next/last variants
          -- NOTE: These override built-in LSP selection mappings on Neovim>=0.12
          -- Map LSP selection manually to use it (see `:h MiniAi.config`)
          around_next = 'an',
          inside_next = 'in',
          around_last = 'al',
          inside_last = 'il',

          -- Move cursor to corresponding edge of `a` textobject
          goto_left = 'g[',
          goto_right = 'g]',
        },

        -- Number of lines within which textobject is searched
        n_lines = 50,

        -- How to search for object (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
        search_method = 'cover_or_next',

        -- Whether to disable showing non-error feedback
        -- This also affects (purely informational) helper messages shown after
        -- idle time if user input is required.
        silent = false,
      })
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
          left = '<M-C-h>',
          right = '<M-C-l>',
          down = '<M-C-j>',
          up = '<M-C-k>',

          -- Move current line in Normal mode
          line_left = '<M-C-h>',
          line_right = '<M-C-l>',
          line_down = '<M-C-j>',
          line_up = '<M-C-k>',
        },
      })
    end,
  }
}
