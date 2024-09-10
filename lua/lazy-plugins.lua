require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  require 'kickstart.plugins.tmux-navigator',
  -- Code QOL
  require 'kickstart.plugins.comment',
  require 'kickstart.plugins.vim-be-good',
  require 'kickstart.plugins.which-key',
  require 'kickstart.plugins.telescope',
  require 'kickstart.plugins.treesitter',
  require 'kickstart.plugins.mini',
  require 'kickstart.plugins.todo-comments',
  require 'kickstart.plugins.conform',
  require 'kickstart.plugins.undotree',
  require 'kickstart.plugins.nvim-spectre',
  require 'kickstart.plugins.apm',
  -- visual
  require 'kickstart.plugins.gitsigns',
  require 'kickstart.plugins.tokyonight',
  require 'kickstart.plugins.dressing',
  -- lsp/dap/lint/formatter:
  require 'kickstart.plugins.copilot',
  require 'kickstart.plugins.snippet',
  require 'kickstart.plugins.clangd-tools',
  require 'kickstart.plugins.refactoring',
  require 'kickstart.plugins.lspconfig',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.trouble',
  require 'kickstart.plugins.harpoon',
  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
