local M = {}

M.setup = function(lspconfig)
  lspconfig.yamlls.setup({
    settings = {
      yaml = {
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  })
end

return M
