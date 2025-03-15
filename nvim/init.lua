require('config')

vim.keymap.set('n', '<leader>fx', vim.cmd.Ex, { desc = "Open explorer" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

vim.keymap.set("n", "<leader>nh", ":nohl<cr>", { desc = "No highlight" })
vim.keymap.set("n", "<leader>ww", ":set wrap<cr>", { desc = "Set word wrap" })
vim.keymap.set("n", "<leader>nw", ":set nowrap<cr>", { desc = "Set word no wrap" })

vim.keymap.set("n", "<leader>x", ":.lua<cr>", { desc = "Run the line under cursor" })
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<cr>", { desc = "Run the current file" })

vim.cmd('language en_US')

vim.g.root_spec = { "cwd" }
vim.g.netrw_banner = 0

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
-- vim.opt.clipboard:append('unnamedplus')
vim.opt.clipboard = 'unnamedplus'

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
-- vim.opt.signcolumn = 'yes'

vim.api.nvim_set_hl(0, 'HighlightYank', { bg = '#6366f1' })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'HighlightYank', timeout = 450 }
  end,
})

