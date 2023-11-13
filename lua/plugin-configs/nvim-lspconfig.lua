local utils = require('utils')

----------------
-- remappings --
----------------

local on_attach = function(client, bufnr)
  local opts = { noremap = true; buffer = bufnr }
  local nmap = function(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, opts)
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Diagnostic specific mappings
  nmap('gn', vim.diagnostic.goto_next)
  nmap('gN', vim.diagnostic.goto_prev)

  -- LSP specific Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nmap('K', vim.lsp.buf.hover)
  nmap('gD', vim.lsp.buf.declaration)
  nmap('gd', vim.lsp.buf.definition)
  nmap('gi', vim.lsp.buf.implementation)
  nmap('gr', vim.lsp.buf.references)
  nmap('<leader>ck', vim.lsp.buf.signature_help)
  nmap('<leader>cwa', vim.lsp.buf.add_workspace_folder)
  nmap('<leader>cwr', vim.lsp.buf.remove_workspace_folder)
  -- todo make this work
  --nmap('<leader>cd', vim.diagnostic.open_float)
  nmap('<leader>cD', vim.lsp.buf.type_definition)
  nmap('<leader>cr', vim.lsp.buf.rename)
  nmap('<leader>ca', vim.lsp.buf.code_action)
  nmap('<leader>cf', vim.lsp.buf.format)
  nmap('<leader>cwl', function () print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)

  print(client.name .. ' language server attached')
end


---------
-- lua --
---------
-- lua lsp install cmd:
-- brew install lua-language-server

-- Setup lspconfig.
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local capabilities = cmp_nvim_lsp.default_capabilities()

local lspconfig = require('lspconfig')

require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})

lspconfig.ocamllsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- todo: this doesn't seem to be working yet
lspconfig.bashls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

--lspconfig.uiua_ls.setup({
--  on_attach = on_attach,
--})
-- rust config is handled by simrat's rust-tools
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
})

utils.setup_au_reload_command()
utils.print_filename_on_reload()
