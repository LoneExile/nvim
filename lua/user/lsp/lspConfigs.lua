local lsp_defaults = require('user.lsp.settings.defaults')
local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
  return
end

lspconfig.util.default_config = vim.tbl_deep_extend('force', lspconfig.util.default_config, lsp_defaults)
require('user.lsp.settings.diagnostic')

local default_handler = function(server)
  -- See :help lspconfig-setup
  lspconfig[server].setup({})
end

local configs = { default_handler }
local servers = {

  'tsserver',
  'vuels',
  -- 'deno',
  -- 'eslint-lsp',
  -- 'emmet-ls',
  'tailwindcss',

  'sumneko_lua', -- Lua
  'pyright', -- python
  'jsonls', -- json

  'csharp_ls', -- c#
  -- 'omnisharp', -- c#

  -- 'rust_analyzer', -- rust
  -- 'lemminx', -- xml
}

for _, server in ipairs(servers) do
  configs[server] = function()
    require('user.lsp.servers.' .. server).setup(lspconfig)
  end
end

-- See :help mason-lspconfig-dynamic-server-setup
require('mason-lspconfig').setup_handlers(configs)
