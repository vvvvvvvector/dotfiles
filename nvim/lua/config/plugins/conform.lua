return {
  "stevearc/conform.nvim",

  config = function()
    local t = { "prettierd" }

    require("conform").setup({
      formatters_by_ft = {
        javascript = t,
        javascriptreact = t,
        typescript = t,
        typescriptreact = t,
        markdown = t,
        html = t,
        css = t,
        scss = t,
        json = t,

        sh = { "shellharden" }
      },

      log_level = vim.log.levels.DEBUG
    })

    vim.keymap.set("n", "<leader>kd", function()
      require("conform").format({
        async = false,
      })
    end, { desc = "Run formatter (conform)" })
  end,
}
