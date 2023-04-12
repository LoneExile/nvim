local M = {}

M.setup = function(_, _)
  return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- enabled = false,
    dependencies = { 'williamboman/mason.nvim' },
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
          'pyright',
          'rust-analyzer',
          'taplo', -- TOML
          'yaml-language-server',
          'json-lsp',
          'typescript-language-server', -- Tsserver
          'tailwindcss-language-server',
          'html-lsp',
          'css-lsp',
          'vetur-vls',
          -- 'emmet-ls', -- emmet
          'astro-language-server',

          -- DAP
          'netcoredbg', -- C#
          'js-debug-adapter', -- JavaScript, TypeScript
          'codelldb', -- Rust

          -- FORMATTER
          'stylua',
          'jq',
          'prettier',
          'black',
          'beautysh',
          'csharpier',
          'markdownlint',
          'yamlfmt',
          'sql-formatter',
          'xmlformatter',

          -- CODE ACTION
          'eslint_d',
          'shellcheck',

          -- DIAGNOSTICS
          'luacheck',
          'flake8',
          'actionlint',
          -- 'sqlfluff',
          'alex',
        },

        auto_update = false,
        run_on_start = true,
        start_delay = 3000, -- 3 second delay
      })

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
