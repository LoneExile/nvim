return {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_dir = function(fname)
    local lspconfig = require('lspconfig')
    return lspconfig.util.root_pattern('pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git')(fname)
      or lspconfig.util.path.dirname(fname)
  end,
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
