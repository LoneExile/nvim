-- Load schemas immediately instead of using a function
-- Functions cannot be serialized with vim.lsp.enable()
local schemas = {}
local status, schemastore = pcall(require, 'schemastore')
if status then
  schemas = schemastore.json.schemas()
end

return {
  settings = {
    json = {
      schemas = schemas,
      validate = { enable = true },
    },
  },
}
