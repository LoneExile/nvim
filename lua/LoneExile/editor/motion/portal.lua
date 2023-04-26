local M = {}

M.setup = function()
  return {
    'cbochs/portal.nvim',
    config = function()
      require('portal').setup({})
    end,
  }
end

return M
