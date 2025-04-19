return {
  'stevearc/conform.nvim',

  opts = {},

  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        markdown = { "prettierd" },
        typescriptreact = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        json = { "prettierd" },
      }
    })

    vim.keymap.set('n', '<leader>kd', function()
      require("conform").format({
        async = false
      })
    end)
  end
}
