return {
  {
    "saghen/blink.cmp",

    dependencies = { "rafamadriz/friendly-snippets" },

    version = "1.*",

    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      signature = { enabled = true, window = { border = 'rounded' } },

      keymap = {
        preset = "default",

        ["<C-space>"] = {},
        ['<C-d>'] = { 'show_documentation', 'hide_documentation' },

        ["<C-i>"] = {
          function(cmp)
            cmp.show({ providers = { "lsp" } })
          end,
        },

        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        documentation = {
          auto_show_delay_ms = 300,
          treesitter_highlighting = true,
          auto_show = false,
          window = {
            border = "rounded",
            scrollbar = false,
          },
        },
        ghost_text = { enabled = false },
        menu = {
          min_width = 20,
          max_height = 12,
          border = "rounded",
          scrollbar = false, -- Note that the gutter will be disabled when border ~= "none"
          draw = {
            columns = {
              { "kind_icon" },
              { "label",    "label_description" },
              { "kind" },
            },
          },
        },
      },

      sources = {
        default = { "lsp", "path", "buffer" },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
