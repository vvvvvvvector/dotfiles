return {
  {
    "nvim-telescope/telescope.nvim",

    -- tag = "0.1.8",

    branch = "master",

    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("telescope").setup({
        defaults = {
          border = true,
          prompt_prefix = "✦ ",
          layout_strategy = "horizontal",
          layout_config = {
            width = 0.90,
            height = 0.90,
          },
          dynamic_preview_title = true,
          mappings = {
            i = {
              ["<C-X>"] = false,

              ["<C-k>"] = "move_selection_previous",
              ["<C-j>"] = "move_selection_next",

              ["J"] = "preview_scrolling_down",
              ["K"] = "preview_scrolling_up",

              ["<C-s>"] = "select_horizontal",


              ['<C-p>'] = require('telescope.actions.layout').toggle_preview
            },
          },
          extensions = {
            fzf = {},
          },
        },
      })

      require("telescope").load_extension("fzf")

      vim.keymap.set("n", "<leader>os", function()
        require("telescope.builtin").find_files({
          cwd = vim.fn.stdpath("config"),
        })
      end, { desc = "Open config" })

      vim.keymap.set("n", "<leader>oh", function()
        require("telescope.builtin").help_tags(require("telescope.themes").get_dropdown({
          previewer = false,
          layout_config = {
            width = 0.55,
            height = 0.55,
          },
        }))
      end, { desc = "Open help" })

      local _find_files_find_command = { "fd", "-H", "-E", ".git", "--type", "f" }

      vim.keymap.set("n", "<leader>pf", function()
        require("telescope.builtin").find_files({
          find_command = _find_files_find_command
        })
      end, { desc = "Open Telescope (with preview)" })

      vim.keymap.set("n", "<leader>pF", function()
        require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({
          previewer = false,
          find_command = _find_files_find_command,
          layout_config = {
            width = 0.55,
            height = 0.55,
          },
        }))
      end, { desc = "Open Telescope" })

      vim.keymap.set("n", "<leader>pq", require("telescope.builtin").live_grep, { desc = "Quick search" })

      vim.keymap.set("n", "<leader>pr", function()
        require("telescope.builtin").lsp_references(require("telescope.themes").get_ivy({
          cwd = vim.fn.stdpath("config"),
        }))
      end, { desc = "Peek References" })

      vim.keymap.set("n", "<leader>pd", require("telescope.builtin").diagnostics, { desc = "Open diagnostics" })

      vim.keymap.set("n", "<leader>pm", require("telescope.builtin").marks, { desc = "Marks" })

      vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
        { desc = "LSP workspace symbols" })

      vim.keymap.set(
        "n",
        "<leader>ds", function()
          require("telescope.builtin").lsp_document_symbols(require("telescope.themes").get_dropdown({
            layout_config = {
              width = 0.60,
              height = 0.30,
            },
          }))
        end,
        { desc = "LSP document symbols" }
      )

      vim.keymap.set("n", "<leader>pb", require("telescope.builtin").buffers, { desc = "Buffers" })

      vim.keymap.set("n", "<leader>:", function()
        require("telescope.builtin").command_history(require("telescope.themes").get_dropdown({
          previewer = false,
          layout_config = {
            width = 0.50,
            height = 0.80,
          },
        }))
      end, { desc = "Open command history" })

      vim.keymap.set("n", "<leader>r", require("telescope.builtin").resume, { desc = "Resume" })

      -- local colors = require('vague.config.internal')._DEFAULT_SETTINGS.colors;

      require("config.colors")._telescope.set_colors()
    end,
  },
}
