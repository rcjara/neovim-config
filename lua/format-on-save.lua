local utils = require('utils')
local lsp_utils = require('lsp_utils')

-- todo: find a home for this
local safely_set_pos = function(window, pos)
  local height = vim.api.nvim_buf_line_count(window)
  pos[1] = math.min(height, pos[1])
  local lines = vim.api.nvim_buf_get_lines(window, pos[1], pos[1], false)
  local line = lines[1] or ""
  pos[2] = math.min(math.max(0, #line - 1), pos[2])

  vim.api.nvim_win_set_cursor(window, pos)
end

local remove_trailing_whitespace = vim.api.nvim_create_augroup('remove_trailing_whitespace', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = '%s/\\s\\+$//e',
  group = remove_trailing_whitespace
})

local run_fmt = vim.api.nvim_create_augroup('run_fmt', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = run_fmt,
  pattern = '*',
  callback = function(_event)
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    if lsp_utils.attached_server_has_capability('documentFormattingProvider') then
      local pos = vim.api.nvim_win_get_cursor(0)
      vim.lsp.buf.format()
      safely_set_pos(0, pos)
    end
  end
})

-- todo: confirm the above works with uiua and then delete this
local run_uiua_fmt = vim.api.nvim_create_augroup('run_uiua_fmt', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = run_uiua_fmt,
  pattern = '*.ua',
  callback = function(_bufnr)
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.schedule(function()
      vim.cmd("!uiua fmt %")
    end)
    --vim.lsp.buf.format()
    vim.api.nvim_win_set_cursor(0, cursor)
  end
})


utils.setup_au_reload_command()
utils.print_filename_on_reload()
