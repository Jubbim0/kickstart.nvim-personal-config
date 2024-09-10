local augroup = vim.api.nvim_create_augroup
local MyGroup = augroup('MyGroup', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
  require('plenary.reload').reload_module(name)
end

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 40,
    }
  end,
})

autocmd({ 'BufWritePre' }, {
  group = MyGroup,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
  group = MyGroup,
  callback = function(e)
    require('clangd_extensions.inlay_hints').setup_autocmd()
    require('clangd_extensions.inlay_hints').set_inlay_hints()
    vim.keymap.set('n', '<leader>ld', function()
      vim.lsp.buf.definition()
    end, { desc = '[L]SP [D]efinition', buffer = e.buf })
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover()
    end, { desc = 'Open Hover Help', buffer = e.buf })
    vim.keymap.set('n', '<leader>ls', function()
      vim.lsp.buf.workspace_symbol()
    end, { desc = '[L]SP [S]ymbol in document', buffer = e.buf })
    vim.keymap.set('n', '<leader>df', function()
      vim.diagnostic.open_float()
    end, { desc = '[D]iagnostic [F]loat', buffer = e.buf })
    vim.keymap.set('n', '<leader>la', function()
      vim.lsp.buf.code_action()
    end, { desc = '[L]SP code [A]ction', buffer = e.buf })
    vim.keymap.set('n', '<leader>lr', function()
      vim.lsp.buf.references()
    end, { desc = '[L]SP [R]eferences', buffer = e.buf })
    vim.keymap.set('n', '<leader>lt', function()
      vim.lsp.buf.type_definition()
    end, { desc = '[L]SP [T]ype Definition', buffer = e.buf })
    vim.keymap.set('n', '<leader>rv', function()
      vim.lsp.buf.rename()
    end, { desc = '[R]ename [V]ariable', buffer = e.buf })
    vim.keymap.set('i', '<C-h>', function()
      vim.lsp.buf.signature_help()
    end, { desc = 'Signatue [H]elp', buffer = e.buf })
    vim.keymap.set('n', '[d', function()
      vim.diagnostic.goto_next()
    end, { desc = 'Next Diagnostic Message', buffer = e.buf })
    vim.keymap.set('n', ']d', function()
      vim.diagnostic.goto_prev()
    end, { desc = 'Previous Diagnostic Message', buffer = e.buf })
  end,
})
