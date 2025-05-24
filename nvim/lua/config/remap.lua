local toggle_word_wrap = function()
	if vim.wo.wrap then
		vim.cmd("set nowrap")
	else
		vim.cmd("set wrap")
	end
end

-- print(vim.inspect(vim.wo.wrap))

vim.keymap.set("n", "<leader>rw", toggle_word_wrap, { desc = "Toggle word wrap" })
vim.api.nvim_create_user_command("ToggleWordWrap", toggle_word_wrap, {})

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open oil" })
vim.keymap.set("n", "<leader>,", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Open diagnostic float" })

-- vim.keymap.set("n", "<leader>zm", "<cmd>ZenMode<cr>", { silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

vim.keymap.set("n", "<leader>nh", "<cmd>nohl<cr>", { desc = "No highlight" })

vim.keymap.set("n", "<C-p>", "<cmd>cprev<cr>zz")
vim.keymap.set("n", "<C-n>", "<cmd>cnext<cr>zz")

vim.keymap.set("n", "<C-j>", "<cmd>cnext<cr>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<cr>zz")

vim.keymap.set("n", "<M-l>", "<C-w>5<")
vim.keymap.set("n", "<M-h>", "<C-w>5>")
-- vim.keymap.set("n", "<M-k>", "<C-w>+")
-- vim.keymap.set("n", "<M-j>", "<C-w>-")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<cr>", { desc = "Run current lua file" })
vim.keymap.set("n", "<leader>x", ":.lua<cr>", { desc = "Run lua code line under cursor" })
vim.keymap.set("v", "<leader>x", ":lua<cr>", { desc = "Execute lua selection" })
