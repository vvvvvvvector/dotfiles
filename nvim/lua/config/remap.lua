local toggle_word_wrap = function()
  if vim.wo.wrap then
    vim.cmd("set nowrap")
  else
    vim.cmd("set wrap")
  end
end

local close_floats = function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "win" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

-- print(vim.inspect(vim.wo.wrap))

vim.keymap.set("n", "<leader>ww", toggle_word_wrap, { desc = "Toggle word wrap" })
vim.api.nvim_create_user_command("ToggleWordWrap", toggle_word_wrap, {})

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open Oil" })
vim.keymap.set("n", "<leader>E", "<cmd>Oil --float<cr>", { desc = "Open Oil --float" })
vim.keymap.set("n", "<leader>,", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Open diagnostic float" })

vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewFileHistory %<cr>", { desc = "File history for current file" })

-- vim.keymap.set("n", "<leader>zm", "<cmd>ZenMode<cr>", { silent = true })

vim.keymap.set("n", "]<tab>", "<cmd>tabn<cr>", { desc = "Next tab" })
vim.keymap.set("n", "[<tab>", "<cmd>tabp<cr>", { desc = "Prev tab" })

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

local copy_relative_path = function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end

vim.keymap.set("n", "<leader>crp", copy_relative_path, { desc = "Copy relative path to the clipboard" })

vim.api.nvim_create_user_command("CopyRelativePath", copy_relative_path, {})
vim.api.nvim_create_user_command("CloseFloats", close_floats, {})

vim.keymap.set("n", "§", "<c-w><c-w>")
