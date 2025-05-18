local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}

  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

return {
  "ThePrimeagen/harpoon",

  branch = "harpoon2",

  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    vim.keymap.set("n", "<leader>hf", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Harpoon menu toggle" })

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add file to Harpoon list" })

    vim.keymap.set("n", "<leader>ht", function() toggle_telescope(harpoon:list()) end,
      { desc = "Open Harpoon window in Telescope" })

    for i = 1, 4 do
      vim.keymap.set("n", "<leader>" .. i, function() harpoon:list():select(i) end)
    end

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>hk", function() harpoon:list():prev() end, { desc = "Prev in Harpoon list" })
    vim.keymap.set("n", "<leader>hj", function() harpoon:list():next() end, { desc = "Next in Harpoon list" })

    harpoon:extend({
      UI_CREATE = function(cx)
        vim.keymap.set("n", "<C-v>", function()
          harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr })

        vim.keymap.set("n", "<C-t>", function()
          harpoon.ui:select_menu_item({ tabedit = true })
        end, { buffer = cx.bufnr })

        local _harpoon = require('config.colors')._harpoon.current_file

        vim.api.nvim_set_hl(0, "HarpoonLine", { fg = _harpoon.fg, bg = _harpoon.bg, bold = true })

        for line_number, file in pairs(cx.contents) do
          if string.find(cx.current_file, file, 1, true) then
            -- highlight the harpoon menu line that corresponds to the current buffer
            vim.api.nvim_buf_add_highlight(
              cx.bufnr,
              -1,
              "HarpoonLine",
              line_number - 1,
              0,
              -1
            )
            -- set the position of the cursor in the harpoon menu to the start of the current buffer line
            vim.api.nvim_win_set_cursor(cx.win_id, { line_number, 0 })
          end
        end
      end,
    })
  end
}
