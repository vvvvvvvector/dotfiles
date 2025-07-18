local detail = false

return {
  "stevearc/oil.nvim",
  ---@module "oil"
  ---@type oil.SetupOpts
  opts = {
    delete_to_trash = true,
    float = {
      border = "rounded",
      preview_split = "right",
      padding = 0,
      -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      max_width = 0.65,
      max_height = 0.9,
    },
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["<C-v>"] = { "actions.select", opts = { vertical = true } },

      ["<C-h>"] = false,

      ["<C-s>"] = { "actions.select", opts = { horizontal = true } },

      ["gd"] = {
        desc = "Toggle file detail view",
        callback = function()
          detail = not detail
          if detail then
            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
          else
            require("oil").set_columns({ "icon" })
          end
        end,
      },
    },
  },
  -- Optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
