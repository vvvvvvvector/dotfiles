-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
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

  {
    "nvim-treesitter/nvim-treesitter",

    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { 
          "c", "lua", "vim", "vimdoc", "query", 
          "typescript", "javascript", "tsx",
          "sql", "prisma", "json", "jsonc",
        },

        auto_install = true,

        highlight = {
          enable = true,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            -- init_selection = "<leader>is", 		
            node_incremental = "<leader>si",
            scope_incremental = "<leader>ss",
            node_decremental = "<leader>sd",
          },
        },

        textobjects = {
          select = {
            enable = true,

            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim

            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",

              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
            },

            -- v -> charwise; V -> linewise
            selection_modes = {
              ['@function.outer'] = 'v',  

              ['@loop.outer'] = 'v',  
            },

            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects"
  },

  { 
    "catppuccin/nvim", 

    name = "catppuccin",

    priority = 1000 ,

    -- optionally set the colorscheme within lazy config
    init = function()
      vim.cmd("colorscheme catppuccin")
    end
  },

  {
    "kylechui/nvim-surround",

    version = "*", -- Use for stability; omit to use `main` branch for the latest features

    event = "VeryLazy",

    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

  {
    'neovim/nvim-lspconfig'
  },

  {
    'hrsh7th/cmp-nvim-lsp'
  },

  {
    'hrsh7th/nvim-cmp'
  },

  {
    'williamboman/mason.nvim'
  },

  {
    'williamboman/mason-lspconfig.nvim'
  },

  checker = { enabled = true },
})
