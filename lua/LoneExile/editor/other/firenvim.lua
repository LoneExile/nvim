local M = {}

M.setup = function()
  return {
    'glacambre/firenvim',
    build = function()
      vim.fn['firenvim#install'](0)
    end,
  }
end

return M