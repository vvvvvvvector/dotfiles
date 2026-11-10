-- Herdr copy mode: nvim on a terminal's history, read-only.
-- Any yank (v…y, yy, yiw, "+y) goes to the macOS clipboard and closes; q closes.
vim.bo.modifiable = false
vim.wo.number = false
vim.wo.relativenumber = false
vim.wo.signcolumn = "no"

vim.keymap.set("n", "q", "<cmd>qa!<cr>", { buffer = true, nowait = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  buffer = 0,
  callback = function()
    -- pbcopy reads its input in the locale's encoding; the terminal may have none.
    vim.fn.system({ "env", "LANG=en_US.UTF-8", "pbcopy" }, vim.v.event.regcontents)
    vim.schedule(function() vim.cmd("qa!") end)
  end,
})

-- Open on the part of the history that was on screen in scroll mode.
local line = math.min(tonumber(vim.env.HERDR_COPY_LINE or "") or vim.fn.line("$"), vim.fn.line("$"))
vim.api.nvim_win_set_cursor(0, { math.max(line, 1), 0 })
vim.cmd("normal! ztM")
-- At the live end, keep the last line at the bottom instead of empty rows below it.
if vim.fn.line("w$") == vim.fn.line("$") then vim.cmd("normal! Gzb") end
