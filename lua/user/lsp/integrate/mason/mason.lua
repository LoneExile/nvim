local M = {}

M.setup = function(_, _)
  return {
    'williamboman/mason.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    event = { 'BufReadPre', 'InsertEnter' },
  }
end

return M
