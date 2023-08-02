local M = {}

M.setup = function()
  return {
    'Hoffs/omnisharp-extended-lsp.nvim',
    ft = { 'cs' },
  }
end

return M
