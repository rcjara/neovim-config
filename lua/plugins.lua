--autocommand to load this file on save
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerUpdate
  augroup end
]])


return require('packer').startup(function()
  -------------------
  -- color schemes --
  -------------------
  use 'ishan9299/nvim-solarized-lua'

  -- Packer plugin manager (using it here)
  use 'wbthomason/packer.nvim'

  -- treesitter highlighting, colors, etc.
  use {
        'nvim-treesitter/nvim-treesitter',
          run = ':TSUpdate all'
    }

  -- telescope, fzf style search and autocomplete
  use {
    'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
  }

  print "plugins loaded"
end)
