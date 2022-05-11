local nmap = require('utils').remaps.nmap
local telescope = require('telescope')
local builtin = require('telescope.builtin')

require("telescope").setup {
  defaults = {
    prompt_prefix = "= ",
    -- todo: ask someone how the hell mappings work
    mappings = {
      n = {
        -- this line currently does nothing, even though I believe it should turn off a telescope default key command
        ['<C-t>'] = false,
      }
    }
  }
}

nmap('<leader>ff', builtin.find_files)
nmap('<leader>fg', builtin.live_grep)
nmap('<leader>fb', builtin.buffers)
nmap('<leader>fh', builtin.help_tags)

local utils = require('utils')
utils.setup_au_reload_command()
utils.print_filename_on_reload()
