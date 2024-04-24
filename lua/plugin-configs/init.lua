local utils = require('utils')
local packer = require('packer')
utils.setup_au_reload_command({ 'PackerInstall', 'PackerCompile' })

return packer.startup(function()
  local use = packer.use
  ------------------
  -- real plugins --
  ------------------

  -- Packer plugin manager (using it here)
  use 'wbthomason/packer.nvim'

  -- treesitter highlighting, colors, etc.
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  -- todo: treesitter code actions
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- Collection of configurations for the built-in LSP client
  use 'neovim/nvim-lspconfig'
  -- todo check to see that uiua lsp still works before deleting this
  -- use '~/dev/nvim-plugs/nvim-lspconfig-uiua'

  use 'folke/neodev.nvim'        -- lua specific lsp setup
  use 'simrat39/rust-tools.nvim' -- rust lps config

  -- lsp / dap / linters installation and configurations
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  -- coq
  use 'whonore/Coqtail'

  -- agda
  use 'ashinkarov/nvim-agda'


  utils.print_filename_on_reload()
end)
