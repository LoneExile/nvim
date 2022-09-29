local M = {}

M.setup = function(lspconfig)
  lspconfig.jsonls.setup({
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
      },
    },
  })
end

return M
