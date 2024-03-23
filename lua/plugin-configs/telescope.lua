local nmap = require('utils').remaps.nmap
local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup {
  defaults = {
    prompt_prefix = "= ",
    -- todo: ask someone how the hell mappings work
    mappings = {
      n = {
        -- this line currently does nothing, even though I believe it should turn off a telescope default key command
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


nmap('<leader>ff', builtin.find_files)
nmap('<leader>fa', function() builtin.find_files({no_ignore = true}) end)
nmap('<leader>fg', function() builtin.live_grep({additional_args = {"--no-ignore"}}) end)
nmap('<leader>fb', builtin.buffers)
nmap('<leader>fh', builtin.help_tags)

telescope.load_extension('emoji')
nmap('<leader>em', telescope.extensions.emoji.emoji)

local utils = require('utils')
utils.setup_au_reload_command()
utils.print_filename_on_reload()
