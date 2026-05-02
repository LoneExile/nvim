-- LSP Configuration using Neovim 0.10+ core LSP system
--
-- This module configures LSP using the new core LSP approach:
-- 1. Global configuration via vim.lsp.config('*', {...})
-- 2. Server-specific configs in lsp/ directory (runtime path)
-- 3. Server activation via vim.lsp.enable(servers)
--
-- This replaces the traditional lspconfig[server].setup() approach
-- and provides better performance through global defaults and debouncing.
--
-- See lsp/README.md for detailed documentation.

local M = {}

M.keys = {
  {
    '<leader>l',
    '',
    desc = 'LSP',
    mode = 'n',
  },
  {
    '<leader>lf',
    '<cmd>FormatCurrentBuf<CR>',
    desc = 'Format',
    mode = 'n',
  },
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
      { 'mason-org/mason.nvim' },
      { 'mason-org/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp_settings = location .. '.settings'

      -- Setup Mason for LSP server management and installation
      local status_mason, mason = pcall(require, 'mason')
      if not status_mason then
        return
      end
      mason.setup({
        ui = {
          border = 'rounded',
        },
      })

      -- Setup Mason LSPConfig for server management integration
      local status, mason_lspconfig = pcall(require, 'mason-lspconfig')
      if not status then
        return
      end
      -- mason-lspconfig v2: automatic_enable runs vim.lsp.enable() for every
      -- installed server automatically, so we no longer maintain a manual
      -- `servers = {...}` list or call vim.lsp.enable() ourselves. Server
      -- tweaks live in `lsp/<name>.lua` files and are picked up by core.
      mason_lspconfig.setup({
        ensure_installed = {},
        -- Exclude ts_ls so it doesn't double-attach alongside vtsls when
        -- typescript-language-server is still installed locally. vtsls is
        -- the canonical TS server in this config (lsp/vtsls.lua).
        automatic_enable = { exclude = { 'ts_ls' } },
      })

      -- Get LSP capabilities from nvim-cmp for autocompletion integration
      local s, cmpLSP = pcall(require, 'cmp_nvim_lsp')
      if not s then
        return
      end
      local capabilities = cmpLSP.default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Add folding range capabilities for code folding support
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- Load diagnostic configuration and autocmds
      require(lsp_settings .. '.diagnostic').set_diagnostic()
      require(lsp_settings .. '.autocmd')

      -- Rounded borders for hover / signature help. Nvim 0.11+ has a global
      -- `winborder` option that applies to all floating windows (including
      -- LSP hover, completion, and notifications), replacing the deprecated
      -- vim.lsp.with(vim.lsp.handlers.hover, {border=...}) pattern.
      vim.o.winborder = 'rounded'

      -- Global LSP configuration using Neovim 0.10+ core LSP system
      -- This replaces individual lspconfig[server].setup() calls with a unified approach
      vim.lsp.config('*', {
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150, -- Improve performance by debouncing text changes
        },
        on_attach = function(client, _)
          -- Handle server-specific capabilities
          if client.name == 'eslint' then
            client.server_capabilities.documentFormattingProvider = true
          end
        end,
      })

      -- nvim-lspconfig v3 will remove the require('lspconfig') framework;
      -- on Nvim 0.11+ the `lsp/<name>.lua` files in the runtime path are
      -- discovered automatically by vim.lsp.enable(), so the require call
      -- is not needed. mason-lspconfig (automatic_enable = true) calls
      -- vim.lsp.enable() for every installed server.
    end,
  }
end

return M
