local status_ok, mason = pcall(require, 'mason')
if not status_ok then
  vim.notify('mason is not installed', vim.log.levels.ERROR)
  return
end

local status, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status then
  vim.notify('mason-lspconfig is not installed', vim.log.levels.ERROR)
  return
end

mason.setup({
  ui = {
    border = 'rounded',
  },
})
mason_lspconfig.setup({
  ensure_installed = {
    -- lsp
    'sumneko_lua',
    'lua-language-server',
    'pyright',
    'rust_analyzer',
    'bash-language-server',
    'marksman',
    'sqls',

    -- linters
    'eslint_d',
    'flake8',
    'markdownlint',
    'shellcheck',

    -- formatters
    'prettier',
    'black',
    'stylua',
    'shfmt',
    'markdownlint',
  },
})
