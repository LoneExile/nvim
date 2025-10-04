return {
  cmd = { 'helm_ls', 'serve' },
  filetypes = { 'helm' },
  -- NOTE: root_dir function removed for Neovim 0.10+ compatibility
  -- vim.lsp.config() cannot serialize functions
  -- Using default lspconfig root_dir pattern (looks for Chart.yaml)
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
