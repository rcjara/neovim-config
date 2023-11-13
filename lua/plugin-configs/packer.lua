local utils = require('utils')
local packer = require('packer')
utils.setup_au_reload_command({'PackerInstall','PackerCompile'})

return packer.startup(function()
  local use = packer.use
  -------------------
  -- color schemes --
  -------------------
  use 'ishan9299/nvim-solarized-lua'
  use 'folke/tokyonight.nvim'
  use 'bluz71/vim-nightfly-colors'

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

  -- Collection of configurations for the built-in LSP client
  use 'neovim/nvim-lspconfig'
  -- todo check to see that uiua lsp still works before deleting this
  -- use '~/dev/nvim-plugs/nvim-lspconfig-uiua'

  use 'folke/neodev.nvim' -- lua specific lsp setup
  use 'simrat39/rust-tools.nvim'  -- rust lps config

  -- lsp / dap / linters installation and configurations
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  -- snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- coq
  use 'whonore/Coqtail'

  -- agda
  use 'ashinkarov/nvim-agda'

  ---------------------
  -- code completion --
  ---------------------
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lsp-document-symbol"
  use "saadparwaiz1/cmp_luasnip"

  ----------------------------
  -- telescope + extensions --
  ----------------------------
  -- telescope, fzf style search and autocomplete
  use {
    'nvim-telescope/telescope.nvim',
      requires = {
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-fzy-native.nvim'}
      }
  }

  use 'xiyaowong/telescope-emoji.nvim'

  utils.print_filename_on_reload()
end)

