require('config.lazy')

vim.cmd("colorscheme vague")

vim.keymap.set('n', '<leader>e', "<cmd>Oil<cr>", { desc = "Open oil" })
vim.keymap.set('n', '<leader>,', "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Open diagnostic float" })

vim.keymap.set("n", "<leader>zm", ":ZenMode <CR>", { silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

vim.keymap.set("n", "<leader>nh", "<cmd>nohl<cr>", { desc = "No highlight" })

vim.keymap.set("n", "<C-p>", "<cmd>cprev<cr>")
vim.keymap.set("n", "<C-n>", "<cmd>cnext<cr>")

vim.keymap.set("n", "<C-j>", "<cmd>cnext<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<cr>")

local toggle_word_wrap = function()
  if vim.wo.wrap then
    vim.cmd("set nowrap")
  else
    vim.cmd("set wrap")
  end
end

-- print(vim.inspect(vim.wo.wrap))

vim.api.nvim_create_user_command("ToggleWordWrap", toggle_word_wrap, {})
vim.keymap.set("n", "<leader>rw", toggle_word_wrap, { desc = "Toggle word wrap" })

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<cr>", { desc = "Run current lua file" })
vim.keymap.set("n", "<leader>x", ":.lua<cr>", { desc = "Run lua code line under cursor" })
vim.keymap.set("v", "<leader>x", ":lua<cr>", { desc = "Execute lua selection" })

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
vim.opt.signcolumn = 'yes'

vim.api.nvim_set_hl(0, 'HighlightYank', { bg = '#6366f1', bold = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'HighlightYank', timeout = 450 }
  end,
})
