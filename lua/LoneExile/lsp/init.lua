local M = {}

M.wh_key = {
  wh_mappings = {
    l = {
      name = 'LSP',
      f = { '<cmd>FormatCurrentBuf<CR>', 'Format', mode = { 'n' } },
      d = { vim.diagnostic.setloclist, 'Diagnostics', mode = { 'n' } },
      l = {
        name = 'LSP',
        r = { '<cmd>LspRestart<cr>', 'Restart', mode = { 'n' } },
        s = { '<cmd>LspStop<cr>', 'Stop', mode = { 'n' } },
      },
      i = { '<cmd>LspInfo<cr>', 'LSP Info', mode = { 'n' } },
      I = { '<cmd>Mason<cr>', 'Mason', mode = { 'n' } },
    },
  },
}

M.setup = function(_, location)
  return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'InsertEnter' },
    cmd = { 'LspInfo', 'LspRestart', 'LspStop', 'Mason' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- 'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- {
      --   'SmiteshP/nvim-navbuddy',
      --   dependencies = {
      --     'SmiteshP/nvim-navic',
      --     'MunifTanjim/nui.nvim',
      --   },
      --   opts = { lsp = { auto_attach = true } },
      -- },
    },
    config = function()
      local lsp_settings = location .. '.settings'
      local status_lsp, lspconfig = pcall(require, 'lspconfig')
      if not status_lsp then
        return
      end

      local status_mason, mason = pcall(require, 'mason')
      if not status_mason then
        return
      end
      mason.setup({
        ui = {
          border = 'rounded',
        },
      })

      -- See :help mason-lspconfig-dynamic-server-setup
      local status, mason_lspconfig = pcall(require, 'mason-lspconfig')
      if not status then
        return
      end
      mason_lspconfig.setup({
        automatic_installation = false,
        ensure_installed = {},
      })

      require(lsp_settings .. '.keymaps').add_lsp_buffer_keybindings()
      require(lsp_settings .. '.diagnostic')
      require(lsp_settings .. '.autocmd')

      local lsp_defaults = require(lsp_settings .. '.defaults').setup()
      lspconfig.util.default_config = vim.tbl_deep_extend('force', lspconfig.util.default_config, lsp_defaults)

      local default_handler = function(server)
        -- See :help lspconfig-setup
        lspconfig[server].setup({})
      end

      local configs = { default_handler }

      -- servers that list on this, will be use custom config in subfolder
      local servers_name = {

        'tsserver', -- setup with 'jose-elias-alvarez/typescript.nvim'
        'vuels',
        -- 'deno',
        -- 'eslint-lsp',
        -- 'emmet-ls',
        'tailwindcss',

        'lua_ls', -- Lua
        'pyright', -- python
        'jsonls', -- json
        'yamlls', -- yaml

        'csharp_ls', -- c#
        -- 'omnisharp', -- c#

        'rust_analyzer', -- rust
        -- 'lemminx', -- xml
        -- 'sqls', -- sql
      }

      --FIX: this load multiple times?
      for _, server in ipairs(servers_name) do
        configs[server] = function()
          require(location .. '.servers.' .. server).setup(lspconfig)
        end
      end

      ----------------------------------------------------------------------------------------
      mason_lspconfig.setup_handlers(configs)
    end,
  }
end

return M

-- reference: https://github.com/VonHeikemen/nvim-starter
