local nmap = require('utils').remaps.nmap
local telescope = require('telescope.builtin')

nmap('ff', function() telescope.find_files() end)
nmap('fg', function() telescope.live_grep() end)
nmap('fb', function() telescope.buffers() end)
nmap('fh', function() telescope.help_tags() end)

local utils = require('utils')
utils.setup_au_reload_command()
utils.print_filename_on_reload()
