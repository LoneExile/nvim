return {
  filetypes = {
    'astro',
    'css',
    'eruby',
    'html',
    'htmldjango',
    'javascriptreact',
    'less',
    'pug',
    'sass',
    'scss',
    'svelte',
    'typescriptreact',
    'vue',
    'templ',
  },
  cmd = { 'emmet-ls', '--stdio' },
  -- Note: root_dir removed - functions cannot be serialized with vim.lsp.enable()
  -- The default root_dir from lspconfig will be used
  single_file_support = true,
  init_options = {
    html = {
      options = {
        ['bem.enabled'] = true,
      },
    },
  },
}
