local utils = require('utils')

-- colors
vim.opt.background = 'dark'
vim.cmd('colorscheme solarized')

-- line numbers
vim.opt.number = true
vim.opt.rnu = true

-- tab/eol
vim.opt.list = true
vim.opt.listchars = ''
vim.opt.listchars:append('eol:۰')
vim.opt.listchars:append('tab:▸ ')
vim.opt.listchars:append('nbsp:¤')


-- lsp floating window
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'rounded'
  opts.max_width= opts.max_width or 80
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

utils.setup_au_reload_command()
utils.print_filename_on_reload()
