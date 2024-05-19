-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Move text in V mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
-- Regular Workflow
vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'Open [E]xplorer' })
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>m', vim.diagnostic.open_float, { desc = 'Show diagnostic error [M]essages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

function _G.__toggle_contextual(vmode)
  local cfg = require('Comment.config'):get()
  local U = require 'Comment.utils'
  local Op = require 'Comment.opfunc'
  local range = U.get_region(vmode)
  local same_line = range.srow == range.erow

  local ctx = {
    cmode = U.cmode.toggle,
    range = range,
    cmotion = U.cmotion[vmode] or U.cmotion.line,
    ctype = same_line and U.ctype.linewise or U.ctype.blockwise,
  }

  local lcs, rcs = U.parse_cstr(cfg, ctx)
  local lines = U.get_lines(range)

  local params = {
    range = range,
    lines = lines,
    cfg = cfg,
    cmode = ctx.cmode,
    lcs = lcs,
    rcs = rcs,
  }

  if same_line then
    Op.linewise(params)
  else
    Op.blockwise(params)
  end
end

vim.keymap.set('n', '<Leader>cc', '<cmd>set operatorfunc=v:lua.__toggle_contextual<CR>g@', { desc = '[C]omment [C]ontext' })
vim.keymap.set('x', '<Leader>cc', '<cmd>set operatorfunc=v:lua.__toggle_contextual<CR>g@', { desc = '[C]omment [C]ontext' })

-- Paste without recopying
vim.keymap.set('x', '<leader>p', [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- Exit insert mode quick
vim.keymap.set('i', '<C-c>', '<Esc>')
-- Tmux Sessionizer
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
