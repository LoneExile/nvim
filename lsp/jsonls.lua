return {
  settings = {
    json = {
      schemas = function()
        local status, schemastore = pcall(require, 'schemastore')
        if status then
          return schemastore.json.schemas()
        end
        return {}
      end,
      validate = { enable = true },
    },
  },
}
