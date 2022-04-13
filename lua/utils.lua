local M = {}

local function map(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true })
end


M.remaps = {
  nmap = function(lhs, rhs)
    map('n', lhs, rhs)
  end,
  imap = function(lhs, rhs)
    map('i', lhs, rhs)
  end
}

return M
