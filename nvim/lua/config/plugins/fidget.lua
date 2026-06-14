return {
	{
		"j-hui/fidget.nvim",

		event = { "BufEnter" },

		config = function()
			-- Turn on LSP, formatting, and linting status and progress information
			require("fidget").setup({
				notification = {
          override_vim_notify = true,
					window = {
						winblend = 100,
					},
				},
				progress = {
					display = {
						progress_icon = { "dots_negative" },
					},
				},
			})
		end,
	},
}
