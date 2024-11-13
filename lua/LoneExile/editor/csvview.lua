local M = {}
M.keys = {
  {
    '<leader>uc',
    '<cmd>CsvViewToggle<cr>',
    desc = 'CSV View',
    cond = function()
      return vim.bo.filetype == 'csv'
    end,
    hidden = function()
      return vim.bo.filetype ~= 'csv'
    end,
  },
}

M.setup = function()
  return {
    'hat0uma/csvview.nvim',
    ft = 'csv',
    keys = M.keys,
    config = function()
      require('csvview').setup()
    end,
  }
end

return M
