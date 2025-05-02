vim.g.mapleader = " "

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = "yes"

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.clipboard = "unnamedplus" -- vim.opt.clipboard:append("unnamedplus")

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
