return {
  {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.8",

    dependencies = {
      "nvim-lua/plenary.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      "nvim-tree/nvim-web-devicons"
    },

    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            width = 0.90,
            height = 0.90,
            preview_width = 0.5
          },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,

              ["J"] = actions.preview_scrolling_down,
              ["K"] = actions.preview_scrolling_up,
            }
          },
          extensions = {
            fzf = {}
          }
        },
      })

      require("telescope").load_extension("fzf")

      vim.keymap.set('n', '<leader>os', function()
        require("telescope.builtin").find_files {
          cwd = vim.fn.stdpath("config")
        }
      end, { desc = "Open config" })

      vim.keymap.set('n', '<leader>oh', require("telescope.builtin").help_tags, { desc = "Open help" })

      vim.keymap.set('n', '<leader>pf', function()
        require("telescope.builtin").find_files({
          find_command = { "fd", "-H", "-E", ".git", "--type", "f" }
        })
      end, { desc = "Open Telescope" })

      vim.keymap.set('n', '<leader>pq', require("telescope.builtin").grep_string, { desc = "Quick search" })

      vim.keymap.set('n', '<leader>pr', function()
        local opts = require("telescope.themes").get_ivy {
          cwd = vim.fn.stdpath("config")
        }

        require("telescope.builtin").lsp_references(opts)
      end, { desc = "Peek References" })
    end,
  },
}
