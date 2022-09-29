local _, lua_dev = pcall(require, 'lua-dev')

lua_dev.setup({})
local M = {}

M.setup = function(lspconfig)
  lspconfig.sumneko_lua.setup({
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  })
end

return M
