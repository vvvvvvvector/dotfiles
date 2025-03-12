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
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          layout_strategy = "horizontal",
          path_display = {
            truncate = 2
          },
          layout_config = {
            width = 0.90,
            height = 0.90,
            preview_width = 0.575
          },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
            }
          }
        },
      })

      telescope.load_extension("fzf")

      vim.keymap.set('n', '<leader>pf', "<cmd>Telescope find_files<cr>", { desc = "Open Telescope" })
      vim.keymap.set('n', '<leader>pq', "<cmd>Telescope grep_string<cr>")
    end,
  },
}
