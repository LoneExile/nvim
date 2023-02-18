local M = {}

M.setup = function()
  return {
    'nathom/filetype.nvim',
    enabled = false,
    lazy = true,
    cmd = 'StartupTime',
  }
end

return M
