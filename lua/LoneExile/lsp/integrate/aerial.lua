local M = {}

M.keys = {
  {
    '<leader>lo',
    '<cmd>AerialToggle!<cr>',
    desc = 'Outline',
    mode = 'n',
  },
  {
    '<leader>ln',
    '<cmd>AerialNavToggle<cr>',
    desc = 'Outline Nav',
    mode = 'n',
  },
}

M.setup = function(_, _)
  return {
    'stevearc/aerial.nvim',
    keys = M.keys,
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  }
end

return M
