local M = {}

M.ft = { 'csv' }

M.keys = {
  {
    '<leader>uc',
    '<cmd>CsvViewToggle<cr>',
    desc = 'CSV View',
    cond = function()
      return vim.tbl_contains(M.ft, vim.bo.filetype)
    end,
    -- hidden = function()
    --   return vim.bo.filetype ~= 'csv'
    -- end,
  },
}

M.setup = function(settings, _)
  return {
    'hat0uma/csvview.nvim',
    ft = M.ft,
    -- keys = M.keys,
    config = function()
      require('csvview').setup()
      settings.utils.cond_keys(M.keys)
    end,
  }
end

return M
