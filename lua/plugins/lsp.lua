local on_attach = function(client, bufnr)
  local opts = { noremap = true, buffer = bufnr }
  local nmap = function(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, opts)
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Diagnostic specific mappings
  nmap('gn', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end)
  nmap('gN', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)
  nmap('gw', vim.diagnostic.goto_next)
  nmap('gW', vim.diagnostic.goto_prev)

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
  nmap('<leader>cwl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)

  print(client.name .. ' language server attached')
end

local servers = {
  'ocamllsp',
  'bashls',
  'gopls',
  'uiua',
}

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = "✅",
          package_pending = "😅",
          package_uninstalled = "❌",
        },
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function(_, opts)
      require("mason-lspconfig").setup()
    end,
    dependencies = {
      'williamboman/mason.nvim'
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function(_,_)
      local lspconfig = require('lspconfig')
      local cmp_nvim_lsp = require('cmp_nvim_lsp')
      local capabilities = cmp_nvim_lsp.default_capabilities()
      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace"
            }
          }
        },
      })
    end,
  },
  {
    'folke/neodev.nvim',  -- lua specific lsp setup
    dependencies = {
      'neovim/nvim-lspconfig'
    },
    ft = { 'lua' },
    config = function(_, _)
      require("neodev").setup({})
    end,
  },
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
    },
    ft = { 'rust' },
    config = function(_, _)
      local rt = require("rust-tools")
      local cmp_nvim_lsp = require('cmp_nvim_lsp')
      local capabilities = cmp_nvim_lsp.default_capabilities()
      rt.setup({
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
      })
    end,
  },
}
