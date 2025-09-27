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
  root_dir = function(fname)
    local lspconfig = require('lspconfig')
    return lspconfig.util.root_pattern('.git')(fname) or lspconfig.util.path.dirname(fname)
  end,
  single_file_support = true,
  init_options = {
    html = {
      options = {
        ['bem.enabled'] = true,
      },
    },
  },
}
