require("config")

vim.cmd("colorscheme vague")

vim.cmd("language en_US")

vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#AEADD1", bg = "#252530", bold = true })
-- vim.api.nvim_set_hl(0, "TabLine", { fg = "white", bg = "#6366f1", })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#141415" })

vim.api.nvim_set_hl(0, "HighlightYank", { fg = "white", bg = "#6366f1", bold = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "HighlightYank", timeout = 450 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove("o")
	end,
})
