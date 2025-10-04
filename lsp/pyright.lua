return {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  -- Note: root_dir removed - functions cannot be serialized with vim.lsp.enable()
  -- The default root_dir from lspconfig will be used (looks for pyproject.toml, setup.py, etc.)
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
