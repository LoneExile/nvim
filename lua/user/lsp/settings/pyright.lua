local M = {}
M.setup = function(lsp)
  lsp.configure('pyright', {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          typeCheckingMode = 'off',

          diagnosticMode = 'workspace',
        },
      },
    },
  })
end
return M
