return {
  {
    "williamboman/mason.nvim",

    branch = "main",

    commit = "fc98833b6da5de5a9c5b1446ac541577059555be",

    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",

    branch = "main",

    commit = "1a31f824b9cd5bc6f342fc29e9a53b60d74af245",

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
    end,
  },
}
