local utils = require('utils')
--
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

-- substitution
vim.opt.gdefault = true

-- search
vim.opt.smartcase = true

-- tabs
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-------------------
-- Global remaps --
-------------------

vim.g.mapleader = ','

local nmap = utils.remaps.nmap
local imap = utils.remaps.imap

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
nmap('<leader>ef', ':vsp <C-R><C-P><CR>') --edit path under cursor

-- when using z to recenter around the cursor, don't go all the way to the top or bottom
nmap('zb', 'zb5<C-E>')
nmap('zt', 'zt5<C-Y>')

-- clear search
nmap('<leader>cx', ':let @/ = ""<CR>')
--
---------------------
-- Terminal remaps --
---------------------

local tmap = utils.remaps.tmap

tmap('<Esc>', '<C-\\><C-N>')

---------------
-- filetypes --
---------------
--todo consider gathering the uiua stuff into a plugin
vim.filetype.add({extension= {ua = 'uiua'}})

---------------
-- Split out --
---------------
require('appearance')

-------------------------------
-- individual plugin configs --
-------------------------------
-- these come after our default mappings in case plugins have overwritten remaps for particular filetypes, etc.
require('plugin-configs/packer')
require('plugin-configs/nvim-treesitter')
require('plugin-configs/mason')
require('plugin-configs/nvim-lspconfig')
require('plugin-configs/luasnip')
require('plugin-configs/telescope')
require('plugin-configs/nvim-cmp')

------------------
-- autocommands --
------------------

local remove_trailing_whitespace = vim.api.nvim_create_augroup('remove_trailing_whitespace', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = '%s/\\s\\+$//e',
  group = remove_trailing_whitespace
})

--todo: create autogroup that autoformats if the lsp is attached and enables it
local run_rust_fmt = vim.api.nvim_create_augroup('run_rust_fmt', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = run_rust_fmt,
  pattern = '*.rs',
  callback = function(_bufnr)
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.lsp.buf.format()
    vim.api.nvim_win_set_cursor(0, cursor)
  end
})

local run_uiua_fmt = vim.api.nvim_create_augroup('run_uiua_fmt', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = run_uiua_fmt,
  pattern = '*.ua',
  callback = function(_bufnr)
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.schedule(function ()
      vim.cmd("!uiua fmt %")
    end)
    --vim.lsp.buf.format()
    vim.api.nvim_win_set_cursor(0, cursor)
  end
})

local coq_key_bindings = vim.api.nvim_create_augroup('coq_key_bindings', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = coq_key_bindings,
  pattern = '*.v',
  callback = function(_bufnr)
    nmap('<C-space>', ':CoqNext<CR>')
    nmap('<C-p>', ':CoqPrev<CR>')
    nmap('<space><space>', ':CoqToLine<CR>')
  end
})


utils.setup_au_reload_command()
utils.print_filename_on_reload()
