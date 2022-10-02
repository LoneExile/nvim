local status_ok, mason = pcall(require, 'mason')
if not status_ok then
  return
end

local status, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status then
  return
end

mason.setup({
  ui = {
    border = 'rounded',
  },
})

-- mason ensure installed make slow startup time
mason_lspconfig.setup({
  -- ensure_installed = {
  --   -- lsp
  --   'tsserver',
  --   'sumneko_lua',
  --   'pyright',
  --   'jsonls',
  --   'vuels',
  --
  --   -- linters
  --   'eslint_d',
  --   'flake8',
  --   'markdownlint',
  --   'shellcheck',
  --
  --   -- formatters
  --   'prettier',
  --   'black',
  --   'stylua',
  --   'shfmt',
  --   'markdownlint',
  -- },
})
