-- Bootstra lazy.nvim
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

vim.g.mapleader = ' '

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      import = "config.plugins"
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
      'neovim/nvim-lspconfig',

      dependencies = {
        {
          "folke/lazydev.nvim",
          opts = {
            library = {
              { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
          },
        },
      }
    },

    {
      'hrsh7th/cmp-nvim-lsp'
    },

    {
      'hrsh7th/nvim-cmp'
    },

    {
      "williamboman/mason.nvim",

      config = function()
        require("mason").setup({
          ui = {
            icons = {
              package_installed = "✅",
              package_pending = "->",
              package_uninstalled = "❌"
            }
          }
        })
      end
    },

    {
      'williamboman/mason-lspconfig.nvim',

      dependencies = { "williamboman/mason.nvim" },

      config = function()
        require('mason-lspconfig').setup({
          automatic_installation = false,

          ensure_installed = {},

          handlers = {
            function(server_name)
              require('lspconfig')[server_name].setup({})
            end,
          },
        })
      end
    },
  },

  checker = {
    enabled = true
  },
})

