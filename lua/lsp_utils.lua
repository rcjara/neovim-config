local M = {}

local get_nested_data = function(object, path)
  local cursor = object
  for _, p in pairs(path) do
    if cursor == nil then
      return nil
    end
    cursor = cursor[p]
  end
  return cursor
end

M.attached_server_has_capability = function(capability)
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  return get_nested_data(clients, { 1, 'server_capabilities', capability })
end

return M
