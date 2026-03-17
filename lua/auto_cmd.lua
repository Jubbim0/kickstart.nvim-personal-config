local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local MyGroup = augroup('MyGroup', { clear = true })
local yank_group = augroup('HighlightYank', { clear = true })

-- Optional: safer reload helper (doesn't explode if plenary isn't available)
local function R(name)
  local ok, reload = pcall(require, 'plenary.reload')
  if ok then
    reload.reload_module(name)
  end
end
_G.R = R -- keep global if you rely on :lua R("..."), otherwise delete this line

-- Highlight on yank
autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

-- Trim trailing whitespace on save (a little safer)
autocmd('BufWritePre', {
  group = MyGroup,
  pattern = '*',
  command = [[keeppatterns keepjumps %s/\s\+$//e]],
})

-- LSP attach
autocmd('LspAttach', {
  group = MyGroup,
  callback = function(e)
    local bufnr = e.buf

    -- Helper for buffer-local mappings
    local function nmap(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc })
    end
    local function imap(lhs, rhs, desc)
      vim.keymap.set('i', lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- Standard LSP mappings (buffer-local)
    nmap('<leader>ld', vim.lsp.buf.definition, '[L]SP [D]efinition')
    nmap('K', vim.lsp.buf.hover, 'Open Hover Help')
    nmap('<leader>ls', vim.lsp.buf.workspace_symbol, '[L]SP [S]ymbol (workspace)')
    nmap('<leader>df', vim.diagnostic.open_float, '[D]iagnostic [F]loat')
    nmap('<leader>la', vim.lsp.buf.code_action, '[L]SP Code [A]ction')
    nmap('<leader>lr', vim.lsp.buf.references, '[L]SP [R]eferences')
    nmap('<leader>lt', vim.lsp.buf.type_definition, '[L]SP [T]ype Definition')
    nmap('<leader>rv', vim.lsp.buf.rename, '[R]ename [V]ariable')
    imap('<C-h>', vim.lsp.buf.signature_help, 'Signature Help')

    -- Diagnostics: conventional direction
    nmap('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic Message')
    nmap(']d', vim.diagnostic.goto_next, 'Next Diagnostic Message')

    -- Inlay hints: use Neovim built-in API; only enable for clangd
    -- (avoids requiring plugin-internal modules that change over time)
    local client = nil
    if e.data and e.data.client_id then
      client = vim.lsp.get_client_by_id(e.data.client_id)
    end

    if client and client.name == 'clangd' then
      -- Neovim 0.10+ supports this API; pcall keeps it safe if API changes
      pcall(function()
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end)
    end
  end,
})
