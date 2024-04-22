return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzy-native.nvim'
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup {
        defaults = {
          prompt_prefix = "= ",
          mappings = {
            i = {
              ['<C-t>'] = false,
            }
          },
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--no-ignore-files', -- also search in gitignore files
          },
        },
        extensions = {
          emoji = {
            action = function(emoji)
              --vim.fn.setreg('"', emoji.value)
              --print([[Press p or "*p to paste this emoji]] .. emoji.value)
              vim.api.nvim_put({ emoji.value }, 'c', false, true)
            end,
          },
        },
      }
    end,
    keys = {
      { '<leader>ff', require('telescope.builtin').find_files, desc = "Telescope builtin.find_files" },
      { '<leader>fa', function() require('telescope.builtin').find_files({ no_ignore = true, hidden = true }) end, desc = "Telescope builtin.find_files (all)" },
      { '<leader>fg', function() require('telescope.builtin').live_grep({ additional_args = { "--no-ignore" } }) end, desc = "Telescope builtin.live_grep" },
      { '<leader>fb', require('telescope.builtin').buffers, desc = "Telescope builtin.buffers" },
      { '<leader>fh', require('telescope.builtin').help_tags, desc = "Telescope builtin.help_tags" },
      { '<leader>fc', require('telescope.builtin').colorscheme, desc = "Telescope builtin.colorscheme" },
    },
  },
  { 'xiyaowong/telescope-emoji.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { '<leader>fe', require("telescope").extensions.emoji.emoji, desc = "Telescope plugin: emoji" },
    },
  },
}
