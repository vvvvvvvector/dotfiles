vim.keymap.set('n', '<leader>ex', vim.cmd.Ex, { desc = "Explorer" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

vim.keymap.set("n", "<leader>nh", ":nohl<cr>", { desc = "No highlight" })

vim.keymap.set("n", "<leader>to", ":tabnew<cr>", { desc = "Open new tab" }) 
vim.keymap.set("n", "<leader>tw", ":tabclose<cr>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>t]", ":tabn<cr>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>t[", ":tabp<cr>", { desc = "Go to previous tab" })

print('hello from remap.lua')
