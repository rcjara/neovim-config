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
    }
  }
}

nmap('<leader>ff', builtin.find_files)
nmap('<leader>fg', builtin.live_grep)
nmap('<leader>fb', builtin.buffers)
nmap('<leader>fh', builtin.help_tags)

-----------
-- emoji --
-----------
require('telescope-emoji').setup({
  action = function(emoji)
    vim.fn.setreg('"', emoji.value)
    print([[Press p or "*p to paste this emoji]] .. emoji.value)
  end,
})
telescope.load_extension('emoji')
nmap('<leader>em', function () telescope.extensions.emoji.emoji {} end)

local utils = require('utils')
utils.setup_au_reload_command()
utils.print_filename_on_reload()
