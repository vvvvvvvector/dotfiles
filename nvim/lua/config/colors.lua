local M = {}

local _telescope_reusable = {
  _title_fg = "#141415",
  _prompt = {
    _title = {
      bg = "#e8b589"
    }
  }
}

local _telescope = {
  results = {
    bg = "#0f0f0f"
  },
  preview = {
    bg = "#1c1c24",
    fg = "#aeaed1",
    title = {
      bg = "#c48282",
      fg = _telescope_reusable._title_fg,
    }
  },
  prompt = {
    bg = "#252530",
    fg = "#cdcdcd",
    title = {
      bg = _telescope_reusable._prompt._title.bg,
      fg = _telescope_reusable._title_fg
    },
    prefix = _telescope_reusable._prompt._title.bg
  }
}

local _harpoon = {
  current_file = {
    fg = "#c48282",
    bg = "#141415"
  }
}

M._telescope = _telescope
M._harpoon = _harpoon

return M
