local M = {}

M.setup = function()
  return {
    'tpope/vim-repeat',
    event = 'BufRead',
  }
end

return M
