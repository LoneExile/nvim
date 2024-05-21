local M = {}

M.setup = function()
  return {
    -- 'Hoffs/omnisharp-extended-lsp.nvim',
    'LoneExile/omnisharp-extended-lsp.nvim',
    branch = 'fix-remove-deprecated-functions',
    ft = { 'cs' },
  }
end

return M
