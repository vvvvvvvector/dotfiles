return {
  {
    'saghen/blink.cmp',

    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      signature = { enabled = true },

      keymap = {
        preset = 'default',

        ['<C-space>'] = {},

        ['<C-j>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
      },

      appearance = {
        nerd_font_variant = 'mono'
      },

      completion = { documentation = { auto_show = false } },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" }
  }
}
