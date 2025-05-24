local M = {}

local _telescope_reusable = {
  _title_fg = "#141415",
  _prompt_title_bg = "#e8b589",
}

local _telescope = {
  results = {
    bg = "#0f0f0f",
  },
  preview = {
    bg = "#1c1c24",
    fg = "#aeaed1",
    title = {
      bg = "#c48282",
      fg = _telescope_reusable._title_fg,
    },
  },
  prompt = {
    bg = "#252530",
    fg = "#cdcdcd",
    title = {
      bg = _telescope_reusable._prompt_title_bg,
      fg = _telescope_reusable._title_fg,
    },
    prefix = _telescope_reusable._prompt_title_bg,
  },
}

_telescope.set_colors = function()
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = _telescope.results.bg })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = _telescope.results.bg, bg = _telescope.results.bg })

      vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { fg = _telescope.preview.fg, bg = _telescope.preview.bg })
      vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = _telescope.preview.bg, bg = _telescope.preview.bg })
      vim.api.nvim_set_hl(
        0,
        "TelescopePreviewTitle",
        { fg = _telescope.preview.title.fg, bg = _telescope.preview.title.bg }
      )

      vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = _telescope.prompt.fg, bg = _telescope.prompt.bg })
      vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = _telescope.prompt.bg, bg = _telescope.prompt.bg })
      vim.api.nvim_set_hl(
        0,
        "TelescopePromptTitle",
        { fg = _telescope.prompt.title.fg, bg = _telescope.prompt.title.bg }
      )
      vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = _telescope.prompt.prefix })

      -- vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#141415", bg = "#141415" })

      -- vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "green", bg = "red" })
    end,
  })
end

local _harpoon = {
  current_file = {
    fg = "#c48282",
    bg = "#141415",
  },
}

M._telescope = _telescope
M._harpoon = _harpoon

return M
