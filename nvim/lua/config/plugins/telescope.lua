return {
  {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.8",

    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons"
    },

    config = function()
      require("telescope").setup({
        defaults = {
          border = true,
          layout_strategy = "horizontal",
          layout_config = {
            width = 0.90,
            height = 0.90,
          },
          dynamic_preview_title = true,
          mappings = {
            i = {
              ["<C-k>"] = "move_selection_previous",
              ["<C-j>"] = "move_selection_next",

              ["J"] = "preview_scrolling_down",
              ["K"] = "preview_scrolling_up",

              ["<C-h>"] = "select_horizontal",

              ["<C-X>"] = false,
            }
          },
          extensions = {
            fzf = {}
          }
        },
      })

      require("telescope").load_extension("fzf")

      vim.keymap.set("n", "<leader>os", function()
        require("telescope.builtin").find_files {
          cwd = vim.fn.stdpath("config")
        }
      end, { desc = "Open config" })

      vim.keymap.set("n", "<leader>oh", require("telescope.builtin").help_tags, { desc = "Open help" })

      vim.keymap.set("n", "<leader>pf", function()
        require("telescope.builtin").find_files({
          find_command = { "fd", "-H", "-E", ".git", "--type", "f" }
        })
      end, { desc = "Open Telescope" })

      vim.keymap.set("n", "<leader>pq", require("telescope.builtin").live_grep, { desc = "Quick search" })

      vim.keymap.set("n", "<leader>pr", function()
        local opts = require("telescope.themes").get_ivy {
          cwd = vim.fn.stdpath("config")
        }

        require("telescope.builtin").lsp_references(opts)
      end, { desc = "Peek References" })

      vim.keymap.set("n", "<leader>pd", require("telescope.builtin").diagnostics, { desc = "Open diagnostics" })

      vim.keymap.set("n", "<leader>pm", require("telescope.builtin").marks, { desc = "Marks" })

      vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols)

      vim.keymap.set("n", "<leader>pb", require("telescope.builtin").buffers)

      local _titles = "#141415"
      local _files = "#141415"

      local _preview = "#1C1C24"
      local _prompt = "#252530"

      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          -- vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#141415", bg = "#141415" })

          vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = _files, bg = _files })
          vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = _files, bg = _files })

          vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { fg = _preview, bg = _preview })
          vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = _preview, bg = _preview })

          vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = _titles, bg = "#C48282" })

          vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = "#CDCDCD", bg = _prompt })
          vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = _prompt, bg = _prompt })

          vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = _titles, bg = "#E8B588" })
          vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = "#E8B588", bg = _prompt })
        end
      })
    end,
  },
}
