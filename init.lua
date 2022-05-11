
function P(obj)
  print (vim.inspect(obj))
end
--------------------
-- global options --
--------------------

--------------
-- spelling --
--------------
vim.opt.spelllang = 'en_us'

-- status line
-- todo: figure out status line
-- vim.opt.statusline = '%-50(%-0f%-0m%-0r%-0h%) %(%l/%L%)'

-- colors
vim.opt.background = 'dark'
vim.cmd('colorscheme solarized')

-- line numbers
vim.opt.number = true
vim.opt.rnu = true

-- substitution
vim.opt.gdefault = true

-- search
vim.opt.smartcase = true

-- tabs
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- tab/eol
vim.opt.list = true
vim.opt.listchars = ''
vim.opt.listchars:append('eol:¬')
vim.opt.listchars:append('tab:▸ ')
vim.opt.listchars:append('nbsp:¤')

-------------------
-- Global remaps --
-------------------

vim.g.mapleader = ','

local nmap = require('utils').remaps.nmap
local imap = require('utils').remaps.imap

--escape
imap('jj', '<Esc>')

-- Insert spaces without entering insert mode
nmap('<Space>', 'i<Space><Esc>')

-- save on
nmap('<CR>', ':w<CR>')
nmap('Z', 'ZZ')

-- split navigation
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

-- config files for edit
nmap('<leader>ec', ':tabedit $MYVIMRC<CR>')
nmap('<leader>rc', ':source $MYVIMRC<CR>')


-- relative file edits (non fzf')
nmap('<leader>ew', ':e <C-R>=expand("%:p:h") . "/" <CR>')
nmap('<leader>es', ':sp <C-R>=expand("%:p:h") . "/" <CR>')
nmap('<leader>ev', ':vsp <C-R>=expand("%:p:h") . "/" <CR>')
nmap('<leader>et', ':tabe <C-R>=expand("%:p:h") . "/" <CR>')
nmap('<leader>ef', ':vsp <C-R><C-P><CR>')  --edit path under cursor

-- when using z to recenter around the cursor, don't go all the way to the top or bottom
nmap('zb', 'zb5<C-E>')
nmap('zt', 'zt5<C-Y>')

-- clear search
nmap('<leader>cx', ':let @/ = ""<CR>')


-------------------------------
-- individual plugin configs --
-------------------------------
require('packer_config')
require('nvim_treesitter_config')
require('telescope_config')
require('nvim_lspconfig_config')

------------------
-- autocommands --
------------------

local remove_trailing_whitespace = vim.api.nvim_create_augroup('remove_trailing_whitespace', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = '%s/\\s\\+$//e',
  group = remove_trailing_whitespace
})

local utils = require('utils')
utils.setup_au_reload_command()
utils.print_filename_on_reload()
