local utils = require('lsp._utils')

return {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_dir = utils.root_dir(utils.root_patterns.python),
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
      },
    },
  },
}
