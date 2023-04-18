local M = {}

M.setup = function(_, _)
  return {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    event = { 'BufReadPre', 'InsertEnter' },
  }
end

return M
