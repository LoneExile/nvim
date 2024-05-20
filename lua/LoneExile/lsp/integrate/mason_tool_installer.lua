local M = {}

M.setup = function(_, _)
  return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = { 'BufReadPre', 'InsertEnter' },
    cmd = { 'MasonToolsInstall' },
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local status_tool, mason_tool = pcall(require, 'mason-tool-installer')
      if not status_tool then
        print('mason-tool-installer is not installed')
        return
      end

      -- TODO: add if have X install X

      -- fix: https://cli.github.com/
      mason_tool.setup({
        ensure_installed = {

          -- LSP
          'lua-language-server',
          'bash-language-server',
          -- 'csharp-language-server', -- C#
          'omnisharp',
          -- 'clangd', -- C++
          'dockerfile-language-server',
          'marksman', -- Markdown
          'ruff-lsp', -- Python
          'pyright', -- Python
          'rust-analyzer',
          'taplo', -- TOML
          'yaml-language-server',
          'json-lsp',
          'typescript-language-server', -- Tsserver
          'eslint-lsp',
          'tailwindcss-language-server',
          'html-lsp',
          'css-lsp',
          'vetur-vls',
          -- 'emmet-ls', -- emmet
          'astro-language-server',
          'yaml-language-server',
          'gopls', -- Go
          'golangci-lint-langserver', -- Go
          'templ', -- Go templ
          'htmx-lsp', -- htmx
          'svelte-language-server', -- Svelte

          'groovy-language-server', -- Groovy (openjdk-11.0.2)
          'npm-groovy-lint',
          'docker-compose-language-service',

          -- DAP
          'netcoredbg', -- C#
          'js-debug-adapter', -- JavaScript, TypeScript
          'codelldb', -- Rust
          'delve', -- Go
          'go-debug-adapter', -- Go
          'debugpy', -- Python

          -- FORMATTER
          'stylua', -- Lua
          'black', -- Python
          'isort', -- Python
          'shfmt', -- Shell
          -- 'csharpier', -- C#
          'markdownlint', -- Markdown
          'prettierd',
          -- 'vale', -- Markdown
          'yamlfmt',
          'sql-formatter',
          'lemminx', -- XML
          'golines', -- Go
          'goimports', -- Go
          'codespell',

          -- CODE ACTION
          'impl', -- Go

          -- DIAGNOSTICS
          'selene',
          -- 'flake8', -- Python
          'actionlint',
          -- 'sqlfluff',
          'alex',
          'gomodifytags', -- Go
          'gotests', -- Go
          'hadolint', -- Dockerfile

          --- c++
          -- 'clangd' -- lsp
          -- 'cpplint', -- diagnostics
          -- 'clang-format', -- formatter
        },

        auto_update = false,
        run_on_start = false,
        start_delay = 3000, -- 3 second delay
      })

      -- since we are lazy loading mason-tool-installer, we need to manually call the install function
      vim.cmd('MasonToolsInstall')

      -- vim.api.nvim_create_autocmd('User', {
      --   pattern = 'MasonToolsUpdateCompleted',
      --   callback = function()
      --     vim.schedule(function()
      --       print('mason-tool-installer has finished')
      --     end)
      --   end,
      -- })
    end,
  }
end

return M

-------------------------------------------------------------------
