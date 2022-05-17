local utils = require('utils')
local packer = require('packer')
utils.setup_au_reload_command({'PackerInstall','PackerCompile'})

return packer.startup(function()
  local use = packer.use
  -------------------
  -- color schemes --
  -------------------
  use 'ishan9299/nvim-solarized-lua'

  ------------------
  -- real plugins --
  ------------------

  -- Packer plugin manager (using it here)
  use 'wbthomason/packer.nvim'

  -- treesitter highlighting, colors, etc.
  use {
        'nvim-treesitter/nvim-treesitter',
          run = ':TSUpdate all'
  }

  -- Collection of configurations for the built-in LSP client
  use 'neovim/nvim-lspconfig'

  -- snippets
  use 'L3MON4D3/LuaSnip'

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

