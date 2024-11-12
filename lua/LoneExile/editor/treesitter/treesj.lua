local M = {}

M.keys = {
  {
    '<leader>uj',
    '<cmd>TSJToggle<cr>',
    desc = 'Split/Join',
    mode = 'n',
  },
}

M.setup = function()
  return {
    'Wansmer/treesj',
    keys = M.keys,
    cmd = { 'TSJToggle' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({ max_join_length = 150 })
    end,
  }
end

return M
