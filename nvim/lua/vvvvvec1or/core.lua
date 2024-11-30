vim.cmd('language en_US')

vim.g.mapleader = ' '

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.wrap = false

vim.opt.ignorecase = true

vim.opt.clipboard:append('unnamedplus')

vim.g.netrw_banner = 0

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'
