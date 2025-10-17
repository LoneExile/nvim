local M = {}

M.keys = { }

M.setup = function()
  return {
    lazy = true,
    cmd = { 'Git' },
    'tpope/vim-fugitive',
  }
end

return M
