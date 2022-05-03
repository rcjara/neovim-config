local M = {}

local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { noremap = true })
end

local config_home_dir = vim.api.nvim_call_function('stdpath',{'config'})

local function this_file_rel()
  local source = debug.getinfo(3, "S").source
  local source, _ = string.gsub(source, '@' .. config_home_dir .. '/', '', 1)
  return source
end

M.remaps = {
  nmap = function(lhs, rhs)
    map('n', lhs, rhs)
  end,
  imap = function(lhs, rhs)
    map('i', lhs, rhs)
  end
}

M.print_filename_on_reload = function()
  print(this_file_rel() .. ' loaded')
  print(' ')
end

M.setup_au_reload_command = function()
  local source = debug.getinfo(2, "S").source
  local source, _ = string.gsub(source, '@', '', 1)
  local group_name = 'reload ' .. source
  local augroup = vim.api.nvim_create_augroup(group_name, { clear = true })
  print('group_name: ' .. group_name)
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = source,
    command = 'source <afile>',
    group = augroup
  })
end


M.print_filename_on_reload()
return M
