local utils = require('lsp._utils')

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
  root_dir = utils.root_dir(utils.root_patterns.git),
  single_file_support = true,
  init_options = {
    html = {
      options = {
        ['bem.enabled'] = true,
      },
    },
  },
}
