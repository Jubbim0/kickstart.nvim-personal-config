return {
  {
    'numToStr/Comment.nvim',
    opts = {
      ---Add a space b/w comment and the line
      padding = true,
      ---Whether the cursor should stay at its position
      sticky = true,
      ---Lines to be ignored while (un)comment
      ignore = nil,
      ---LHS of toggle mappings in NORMAL mode
      toggler = {
        ---Line-comment toggle keymap
        line = '<leader>ctl',
        ---Block-comment toggle keymap
        block = '<leader>ctb',
      },
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        ---Line-comment keymap
        line = '<leader>cl',
        ---Block-comment keymap
        block = '<leader>cb',
      },
      ---LHS of extra mappings
      extra = {
        ---Add comment on the line above
        above = '<leader>cO',
        ---Add comment on the line below
        below = '<leader>co',
        ---Add comment at the end of line
        eol = '<leader>cA',
      },
      ---Enable keybindings
      ---NOTE: If given `false` then the plugin won't create any mappings
      mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
      },
      ---Function to call before (un)comment
      pre_hook = nil,
      ---Function to call after (un)comment
      post_hook = function(ctx)
        local r = unpack(vim.api.nvim_win_get_cursor(0))
        local rcnt = vim.api.nvim_buf_line_count(0)
        if rcnt > r then
          vim.api.nvim_win_set_cursor(0, { r + 1, 0 })
        end
      end,
    },
    lazy = false,
  },
}
