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
      mason_lspconfig.setup({
        automatic_installation = false,
        ensure_installed = {},
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

      -- Set up global LSP handlers with rounded borders
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

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

      -- Initialize lspconfig to register server configurations in runtime path
      -- This must happen before vim.lsp.enable() to ensure server configs are available
      require('lspconfig')

      -- List of servers to enable with vim.lsp.enable()
      -- Server-specific configurations are loaded from lsp/ directory
      local servers = {
        'vuels', -- Vue.js
        'eslint', -- ESLint
        'emmet_ls', -- Emmet
        'tailwindcss', -- Tailwind CSS
        'lua_ls', -- Lua
        'pyright', -- Python
        'jsonls', -- JSON
        'yamlls', -- YAML
        'omnisharp', -- C#
        'rust_analyzer', -- Rust
        'golangci_lint_ls', -- Go linting
        'gopls', -- Go
        'html', -- HTML
        'docker_compose_language_service', -- Docker Compose
        'helm_ls', -- Helm

        'lua-language-server',
        'bash-language-server',
        'dockerfile-language-server',
        'marksman', -- Markdown
        'ruff', -- Python
        'rust-analyzer',
        'taplo', -- TOML
        'yaml-language-server',
        'json-lsp',
        'typescript-language-server', -- Tsserver
        'tailwindcss-language-server',
        'html-lsp',
        'css-lsp',
        'vetur-vls',
        'astro-language-server',
        'golangci-lint',
        'templ', -- Go templ
        'htmx-lsp', -- htmx
        'svelte-language-server', -- Svelte
        'elixir-ls', -- Elixir
        'terraform-ls', -- Terraform
        'tflint',
        'npm-groovy-lint',
        'nil', -- Nix
      }

      -- Enable LSP servers using the new core LSP system
      -- This replaces the traditional mason-lspconfig setup_handlers approach
      vim.lsp.enable(servers)
    end,
  }
end

return M
