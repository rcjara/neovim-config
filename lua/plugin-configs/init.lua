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

  -- coq
  use 'whonore/Coqtail'

  -- agda
  use 'ashinkarov/nvim-agda'


  utils.print_filename_on_reload()
end)
