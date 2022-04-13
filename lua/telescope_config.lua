vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost telescope.lua source <afile> | PackerUpdate
  augroup end
]])

local nmap = require('utils').remaps.nmap
local telescope = require('telescope.builtin')
local tel_cmd = function(cmd)
  return ':Telescope ' .. cmd .. '<CR>'
end

nmap('ff', tel_cmd('find_files'))
nmap('fg', tel_cmd('live_grep'))
nmap('fb', tel_cmd('buffers'))
nmap('fh', tel_cmd('help_tags'))
