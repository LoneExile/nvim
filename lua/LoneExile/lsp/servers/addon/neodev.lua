local M = {}

M.setup = function()
  return {
    'folke/lua-dev.nvim',
    ft = { 'lua' },
    enabled = true,
    -- config = function()
    --   local _, lua_dev = pcall(require, 'neodev')
    --   lua_dev.setup({})
    -- end,
  }
end

return M