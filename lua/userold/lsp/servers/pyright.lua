local M = {}
M.setup = function(lspconfig)
  lspconfig.pyright.setup({
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_dir = function(fname)
      return lspconfig.util.root_pattern('pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git')(fname)
        or lspconfig.util.path.dirname(fname)
    end,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          -- typeCheckingMode = 'off',
          diagnosticMode = 'workspace',
        },
      },
    },
  })
end
return M
