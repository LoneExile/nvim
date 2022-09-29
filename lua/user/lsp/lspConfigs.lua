local lsp_defaults = require('user.lsp.settings.defaults')
local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
  vim.notify('lspconfig is not installed', vim.log.levels.ERROR)
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
  'sumneko_lua',
  'pyright',
  'jsonls',
  'vuels',
  -- 'deno',
}

for _, server in ipairs(servers) do
  configs[server] = function()
    require('user.lsp.servers.' .. server).setup(lspconfig)
  end
end

-- See :help mason-lspconfig-dynamic-server-setup
require('mason-lspconfig').setup_handlers(configs)
