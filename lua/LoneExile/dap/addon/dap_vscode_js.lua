local M = {}

M.setup = function()
  return {
    'mxsdev/nvim-dap-vscode-js',
    -- ft = { 'typescript', 'javascript' },
    dependencies = {
      { 'mfussenegger/nvim-dap' },
    },
  }
end

return M
