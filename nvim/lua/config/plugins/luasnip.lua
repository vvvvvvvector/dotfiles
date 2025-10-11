return {
  "L3MON4D3/LuaSnip",

  config = function()
    local ls = require("luasnip")

    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/config/snippets/" })

    vim.keymap.set({ "i" }, "<C-e>", function() ls.expand() end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-k>", function() ls.jump(1) end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(-1) end, { silent = true })
  end
}
