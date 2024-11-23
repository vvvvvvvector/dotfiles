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
			vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
			vim.keymap.set('n', '<leader>pq', function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end)
		end
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate"
	},

	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
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

	checker = { enabled = true },
})
