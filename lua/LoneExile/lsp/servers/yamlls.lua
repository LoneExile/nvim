local M = {}

M.setup = function(lspconfig)
  local status, schemastore = pcall(require, 'schemastore')
  if not status then
    return
  end

  lspconfig.yamlls.setup({
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = '',
        },
        schemas = schemastore.yaml.schemas(),
      },
    },
  })
end
return M
