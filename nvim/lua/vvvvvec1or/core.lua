vim.cmd('language en_US')

vim.g.mapleader = ' '

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.ignorecase = true

vim.opt.clipboard:append('unnamedplus')

vim.g.netrw_banner = 0

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

vim.api.nvim_set_hl(0, 'HighlightYank', { bg = '#6366f1' })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'HighlightYank', timeout = 450 }
  end,
})

