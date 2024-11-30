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

		dependencies = { "nvim-lua/plenary.nvim" },

		config = function()
			require('telescope').setup({})

			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Open Telescope" })
			vim.keymap.set('n', '<leader>pq', function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "Telescope grep string" })
		end
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
				}
			})
		end,
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
