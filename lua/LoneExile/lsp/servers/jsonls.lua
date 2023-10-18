local M = {}

M.setup = function(lspconfig)
  local status, schemastore = pcall(require, 'schemastore')
  if not status then
    return
  end
  lspconfig.jsonls.setup({
    settings = {
      json = {
        schemas = schemastore.json.schemas(),
        validate = { enable = true },
      },
    },
  })
end

return M
