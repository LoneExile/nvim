local M = {}

M.setup = function(_, location)
  return {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim', 'b0o/schemastore.nvim', 'SmiteshP/nvim-navic' },
    config = function()
      local status_ok, lspconfig = pcall(require, 'lspconfig')
      if not status_ok then
        return
      end

      local lsp_settings = location .. '.settings'
      local lsp_defaults = require(lsp_settings .. '.defaults').setup(lsp_settings)
      -- print(vim.inspect(lsp_defaults))

      lspconfig.util.default_config = vim.tbl_deep_extend('force', lspconfig.util.default_config, lsp_defaults)
      require(lsp_settings .. '.diagnostic')

      local default_handler = function(server)
        -- See :help lspconfig-setup
        lspconfig[server].setup({})
      end

      local configs = { default_handler }

      -- servers that list on this, will be use custom config ('user.lsp.servers.')
      local servers = {

        'tsserver',
        'vuels',
        -- 'deno',
        -- 'eslint-lsp',
        -- 'emmet-ls',
        'tailwindcss',

        'lua_ls', -- Lua
        'pyright', -- python
        'jsonls', -- json

        'csharp_ls', -- c#
        -- 'omnisharp', -- c#

        'rust_analyzer', -- rust
        -- 'lemminx', -- xml
        -- 'sqls', -- sql
      }

      --FIX: this load multiple times
      for _, server in ipairs(servers) do
        configs[server] = function()
          require(location .. '.servers.' .. server).setup(lspconfig)
        end
      end

      -- See :help mason-lspconfig-dynamic-server-setup
      local status, masonLspConfig = pcall(require, 'mason-lspconfig')
      if not status then
        return
      end
      masonLspConfig.setup_handlers(configs)
    end,
  }
end

return M
