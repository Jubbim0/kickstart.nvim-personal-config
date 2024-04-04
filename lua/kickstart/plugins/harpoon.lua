return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
    },
    keys = function()
      local keys = {
        {
          '<leader>ha',
          function()
            require('harpoon'):list():add()
          end,
          desc = 'Harpoon File',
        },
        {
          '<leader>hm',
          function()
            local harpoon = require 'harpoon'
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = 'Harpoon Quick Menu',
        },
        {
          '<C-S-N>',
          function()
            local harpoon = require 'harpoon'
            harpoon:list():next()
          end,
          desc = 'Harpoon Next',
        },
        {
          '<C-S-P>',
          function()
            local harpoon = require 'harpoon'
            harpoon:list():prev()
          end,
          desc = 'Harpoon Previous',
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          '<leader>' .. i,
          function()
            require('harpoon'):list():select(i)
          end,
          desc = 'Harpoon to File ' .. i,
        })
      end
      return keys
    end,
  },
}
