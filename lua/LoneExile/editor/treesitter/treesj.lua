local M = {}

M.wh_key = {
  wh_mappings = {
    u = {
      name = '+Utility',
      j = { '<cmd>TSJToggle<cr>', 'Split/Join', mode = { 'n' } },
    },
  },
}

M.setup = function()
  return {
    'Wansmer/treesj',
    -- keys = { '<space>m', '<space>j', '<space>s' },
    cmd = { 'TSJToggle' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({ max_join_length = 150 })
    end,
  }
end

return M
