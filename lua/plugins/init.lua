return {
  {
    'whonore/Coqtail',
    ft = { 'coq' },
    config = function(_, _)
      local coq_key_bindings = vim.api.nvim_create_augroup('coq_key_bindings', { clear = true })
      local nmap = require('utils').remaps.nmap
      vim.api.nvim_create_autocmd('BufEnter', {
        group = coq_key_bindings,
        pattern = '*.v',
        callback = function(_bufnr)
          nmap('<C-space>', ':CoqNext<CR>')
          nmap('<C-p>', ':CoqPrev<CR>')
          nmap('<space><space>', ':CoqToLine<CR>')
        end
      })
    end,
  }
}
