local M = {}

-- Show hover
-- vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { noremap = true, silent = true })

-- M.wh_key = {
--   wh_mappings = {
--     l = {
--       name = 'LSP',
--       f = { '<cmd>FormatCurrentBuf<CR>', 'Format', mode = { 'n' } },
--       -- d = { vim.diagnostic.setloclist, 'Diagnostics', mode = { 'n' } },
--       x = { '<cmd>LspInfo<cr>', 'LSP Info', mode = { 'n' } },
--       I = { '<cmd>Mason<cr>', 'Mason', mode = { 'n' } },
--       R = { '<cmd>LspRestart<cr>', 'Restart', mode = { 'n' } },
--       z = { '<cmd>LspStop<cr>', 'Stop', mode = { 'n' } },
--     },
--   },
--   -- wh_g_mappings = {
--   --   ['d'] = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Goto Definition' },
--   --   ['s'] = { vim.lsp.buf.signature_help, 'show signature help' },
--   --   ['r'] = { '<cmd>lua vim.lsp.buf.references()<cr>', 'Goto references' },
--   --   ['R'] = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'rename' },
--   --   ['q'] = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action' },
--   --   ['j'] = { '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Next diagnostic' },
--   --   ['k'] = { '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Prev diagnostic' },
--   --   ['D'] = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Goto declaration' },
--   --   ['o'] = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Goto Implementation' },
--   --   ['I'] = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Goto Implementation' },
--   --   ['l'] = { '<cmd>lua vim.diagnostic.open_float()<cr>', 'Show line diagnostics' },
--   --   -- ['f'] = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format' },
--   -- },
-- }

M.keys = {
  {
    '<leader>l',
    function()
      local status, wk = pcall(require, 'which-key')
      if not status then
        return
      end
      wk.show({ global = false })
    end,
    desc = 'LSP',
    mode = 'n',
  },
  {
    '<leader>lf',
    '<cmd>FormatCurrentBuf<CR>',
    desc = 'Format',
    mode = 'n',
  },
  -- {
  --   '<leader>ld',
  --   '<cmd>lua vim.diagnostic.setloclist()<CR>',
  --   desc = 'Diagnostics',
  --   mode = 'n',
  -- }
  {
    '<leader>lx',
    '<cmd>LspInfo<CR>',
    desc = 'LSP Info',
    mode = 'n',
  },
  {
    '<leader>lI',
    '<cmd>Mason<CR>',
    desc = 'Mason',
    mode = 'n',
  },
  {
    '<leader>lR',
    '<cmd>LspRestart<CR>',
    desc = 'Restart',
    mode = 'n',
  },
  {
    '<leader>lz',
    '<cmd>LspStop<CR>',
    desc = 'Stop',
    mode = 'n',
  },
}

M.setup = function(_, location)
  return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'InsertEnter' },
    cmd = { 'LspInfo', 'LspRestart', 'LspStop', 'Mason' },
    -- keys = {
    --   { 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', desc = 'Hover' },
    -- },
    keys = M.keys,

    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- 'WhoIsSethDaniel/mason-tool-installer.nvim',
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

      local s, cmpLSP = pcall(require, 'cmp_nvim_lsp')
      if not s then
        return
      end
      local capabilities = cmpLSP.default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Tell the server the capability of foldingRange,
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- See :help mason-lspconfig-dynamic-server-setup
      local status, mason_lspconfig = pcall(require, 'mason-lspconfig')
      if not status then
        return
      end
      mason_lspconfig.setup({
        automatic_installation = false,
        ensure_installed = {},
      })

      require(lsp_settings .. '.diagnostic').set_diagnostic()
      require(lsp_settings .. '.autocmd')

      local lsp_defaults = require(lsp_settings .. '.defaults').setup(capabilities)
      lspconfig.util.default_config = vim.tbl_deep_extend('force', lspconfig.util.default_config, lsp_defaults)

      local default_handler = function(server)
        -- See :help lspconfig-setup
        lspconfig[server].setup({})
      end

      local configs = { default_handler }

      -- servers that list on this, will be use custom config in subfolder
      local servers_name = {

        -- 'tsserver',
        'vuels',
        -- 'deno',
        'eslint',
        'emmet_ls',
        'tailwindcss',

        'lua_ls', -- Lua
        'pyright', -- python
        'jsonls', -- json
        'yamlls', -- yaml

        -- 'csharp_ls', -- c#
        'omnisharp', -- c#

        'rust_analyzer', -- rust
        -- 'lemminx', -- xml
        -- 'sqls', -- sql
        'golangci_lint_ls', -- Go
        'gopls', -- Go
        'html',
        -- 'vale_ls', -- Markdown, text
        'docker_compose_language_service', -- Docker-compose
        'helm_ls', -- Helm
      }

      for _, server in ipairs(servers_name) do
        configs[server] = function()
          require(location .. '.servers.' .. server).setup(lspconfig, capabilities)
        end
      end

      ----------------------------------------------------------------------------------------
      mason_lspconfig.setup_handlers(configs)
    end,
  }
end

return M

-- reference: https://github.com/VonHeikemen/nvim-starter
