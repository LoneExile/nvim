local M = {}

M.setup = function()
  return {
    'cbochs/portal.nvim',
    enabled = false,
    config = function()
      require('portal').setup({})
    end,
  }
end

return M
