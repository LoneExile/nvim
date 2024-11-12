local M = {}
M.keys = {
  {
    '<leader>ug',
    '<cmd>Neogen<cr>',
    desc = 'Neogen',
    mode = 'n',
  },
}

M.setup = function()
  return {
    'danymat/neogen',
    config = true,
    keys = M.keys,
  }
end

return M
