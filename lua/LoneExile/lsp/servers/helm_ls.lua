local M = {}

M.setup = function(lspconfig, capabilities)
  lspconfig.helm_ls.setup({
    cmd = { 'helm_ls', 'serve' },
    capabilities = capabilities,
    filetypes = { 'helm' },
    root_dir = function(fname)
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
            -- any other config from https://github.com/redhat-developer/yaml-language-server#language-server-settings
          },
        },
      },
    },
    single_file_support = true,
  })
end

return M
