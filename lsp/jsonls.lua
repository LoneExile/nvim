local utils = require('lsp._utils')

return {
  settings = {
    json = {
      schemas = utils.get_schemas('json'),
      validate = { enable = true },
    },
  },
}
