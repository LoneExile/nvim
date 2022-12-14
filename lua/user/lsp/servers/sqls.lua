local M = {}

M.setup = function(lspconfig)
  lspconfig.sqls.setup({
    settings = {
      sqls = {
        connections = {
          {
            driver = 'postgresql',
            dataSourceName = "host=127.0.0.1 port=5432 user=postgres password='' dbname='' sslmode=disable",
          },
        },
      },
    },
  })
end

return M
