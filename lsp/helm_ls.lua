return {
  cmd = { 'helm_ls', 'serve' },
  filetypes = { 'helm' },
  root_dir = function(fname)
    local lspconfig = require('lspconfig')
    return lspconfig.util.root_pattern('Chart.yaml')(fname) or lspconfig.util.path.dirname(fname)
  end,
  settings = {
    ['helm-ls'] = {
      logLevel = 'info',
      valuesFiles = {
        mainValuesFile = 'values.yaml',
        lintOverlayValuesFile = 'values.lint.yaml',
        additionalValuesFilesGlobPattern = 'values*.yaml',
      },
      yamlls = {
        enabled = true,
        diagnosticsLimit = 50,
        showDiagnosticsDirectly = false,
        path = 'yaml-language-server',
        config = {
          schemas = {
            kubernetes = 'templates/**',
          },
          completion = true,
          hover = true,
        },
      },
    },
  },
  single_file_support = true,
}
