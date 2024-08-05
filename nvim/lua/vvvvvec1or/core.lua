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

print('hello core.lua')
