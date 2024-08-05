local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ex', vim.cmd.Ex)

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

print('hello remap.lua')
