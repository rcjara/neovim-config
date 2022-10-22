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
  nmap('<leader>lk', vim.lsp.buf.signature_help)
  nmap('<leader>lwa', vim.lsp.buf.add_workspace_folder)
  nmap('<leader>lwr', vim.lsp.buf.remove_workspace_folder)
  nmap('<leader>lD', vim.lsp.buf.type_definition)
  nmap('<leader>lrn', vim.lsp.buf.rename)
  nmap('<leader>lca', vim.lsp.buf.code_action)
  nmap('<leader>lf', vim.lsp.buf.formatting)
  nmap('<leader>lwl', function () print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)

  print(client.name .. ' language server attached')
end


---------
-- lua --
---------
-- lua lsp install cmd:
-- brew install lua-language-server

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Setup lspconfig.
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local capabilities = cmp_nvim_lsp.default_capabilities()

require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },

    },
  },
}

require('lspconfig').rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {}
  }
}

utils.setup_au_reload_command()
utils.print_filename_on_reload()
