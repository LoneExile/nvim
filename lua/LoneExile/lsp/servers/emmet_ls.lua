local M = {}

M.setup = function(lspconfig, capabilities)
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- capabilities.textDocument.completion.completionItem.snippetSupport = true
  lspconfig.emmet_ls.setup({
    capabilities = capabilities,
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
    root_dir = lspconfig.util.root_pattern('git', 'root'),
    single_file_support = true,
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ['bem.enabled'] = true,
        },
      },
    },
  })
end

return M
