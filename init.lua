function P(obj)
  print (vim.inspect(obj))
end

-----------------------------------
-- make sure plugins are a thing --
-----------------------------------
require('plugins')
require('nvim_treesitter')

--------------------
-- global options --
--------------------

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

local function map(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true })
end

local function nmap(lhs, rhs)
  map('n', lhs, rhs)
end

local function imap(lhs, rhs)
  map('i', lhs, rhs)
end

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

------------------
-- autocommands --
------------------

-- todo: remove vim.cmd
vim.cmd([[
  augroup remove_trailing_whitespace
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
  augroup end
]])

-- todo: remove vim.cmd
vim.cmd([[
  augroup reload_init_lua_on_save
    autocmd!
    autocmd BufWritePost $MYVIMRC source <afile>
  augroup end
]])

-- Don't put anything after this
print "init.lua loaded"
