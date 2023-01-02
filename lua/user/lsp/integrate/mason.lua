local status_ok, mason = pcall(require, 'mason')
if not status_ok then
  return
end

mason.setup({
  ui = {
    border = 'rounded',
  },
})

-------------------------------------------------------------------
local status, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status then
  return
end

mason_lspconfig.setup({
  automatic_installation = false,
  ensure_installed = {},
})

-------------------------------------------------------------------

local status_tool, mason_tool = pcall(require, 'mason-tool-installer')
if not status_tool then
  return
end

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

    -- CODE ACTION
    'eslint_d',
    'shellcheck',

    -- DIAGNOSTICS
    'luacheck',
    'flake8',
    'actionlint',
    -- 'sqlfluff',
  },

  auto_update = false,
  run_on_start = false,
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
