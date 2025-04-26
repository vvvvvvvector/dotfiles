return {
  {
    "williamboman/mason.nvim",

    config = function()
      require("mason").setup()
    end
  },

  {
    "williamboman/mason-lspconfig.nvim",

    dependencies = { "williamboman/mason.nvim" },

    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = false,

        ensure_installed = { "vtsls", "tailwindcss", "prismals" },

        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
        },
      })
    end
  },
}
