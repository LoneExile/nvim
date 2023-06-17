local M = {}

M.setup = function()
  return {
    'wellle/targets.vim',
    event = 'BufRead',
  }
end

return M
