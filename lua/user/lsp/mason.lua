local status_ok_ui, masonSet = pcall(require, 'mason.settings')
if not status_ok_ui then
  vim.notify('Mason not found', vim.log.levels.ERROR)
  return
end

local status, masonCofig = pcall(require, 'mason-lspconfig')
if not status then
  vim.notify('Mason-lspconfig' .. ' not found!')
  return
end

masonSet.set({
  ui = {
    border = 'rounded',
  },
})

masonCofig.setup({
  ensure_installed = {
    -- lsp
    'sumneko_lua',
    'lua-language-server',
    'pyright',
    'rust_analyzer',
    'bash-language-server',
    'marksman',
    'sqls',

    'dockerfile-language-server',
    'yaml-language-server',
    'json-lsp',
    'taplo',

    'html-lsp',
    'typescript-language-server',
    'vue-language-server',

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
