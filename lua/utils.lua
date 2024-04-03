local M = {}

function P(obj)
  print(vim.inspect(obj))
end

function Y(obj, reg)
  if not reg then
    reg = '"'
  end
  vim.fn.setreg(reg, vim.inspect(obj))
end

M.P = P
M.Y = Y

local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { noremap = true })
end

local config_home_dir = vim.api.nvim_call_function('stdpath', { 'config' })

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
  end,
  tmap = function(lhs, rhs)
    map('t', lhs, rhs)
  end,
}

M.path = {
  basename = function(path)
    local basename = string.match(path, '[^/]+$')
    if basename then
      return basename
    else
      return path
    end
  end
}

M.print_filename_on_reload = function()
  print(this_file_rel() .. ' loaded')
end

M.setup_au_reload_command = function(addl_cmds)
  local source = debug.getinfo(2, "S").source
  local source, _ = string.gsub(source, '@', '', 1)
  local group_name = 'reload ' .. source
  local augroup = vim.api.nvim_create_augroup(group_name, { clear = true })
  local add_cmd = function(cmd)
    vim.api.nvim_create_autocmd('BufWritePost', {
      pattern = source,
      command = cmd,
      group = augroup
    })
  end
  add_cmd('source <afile>')

  if type(addl_cmds) == 'string' then
    add_cmd(addl_cmds)
  elseif type(addl_cmds) == 'table' then
    for _, cmd in ipairs(addl_cmds) do
      add_cmd(cmd)
    end
  end
end


M.print_filename_on_reload()
return M
