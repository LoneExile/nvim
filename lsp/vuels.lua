return {
  cmd = { 'vls' },
  filetypes = { 'vue' },
  root_dir = function(fname)
    local lspconfig = require('lspconfig')
    return lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname) or lspconfig.util.path.dirname(fname)
  end,
  init_options = {
    config = {
      css = {},
      emmet = {},
      html = {
        suggest = {},
      },
      javascript = {
        format = {},
      },
      stylusSupremacy = {},
      typescript = {
        format = {},
      },
      vetur = {
        completion = {
          autoImport = false,
          tagCasing = 'kebab',
          useScaffoldSnippets = false,
        },
        format = {
          defaultFormatter = {
            js = 'prettier',
            ts = 'prettier',
          },
          defaultFormatterOptions = {},
          scriptInitialIndent = false,
          styleInitialIndent = false,
        },
        useWorkspaceDependencies = false,
        validation = {
          script = true,
          style = true,
          template = true,
        },
      },
    },
  },
}
