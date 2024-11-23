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

print('hello core.lua')
