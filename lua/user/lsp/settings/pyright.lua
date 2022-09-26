-- local _, lsp = pcall(require, 'lsp-zero')
-- lsp.configure('pyright', {
--   settings = {
--     python = {
--       analysis = {
--         autoSearchPaths = true,
--         useLibraryCodeForTypes = true,
--         typeCheckingMode = 'off',
--       },
--     },
--   },
-- })

local M = {}
M.setup = function(lsp)
  lsp.configure('pyright', {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          typeCheckingMode = 'off',
        },
      },
    },
  })
end
return M
