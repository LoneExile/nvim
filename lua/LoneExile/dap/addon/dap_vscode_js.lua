local M = {}

M.setup = function()
  return {
    'mxsdev/nvim-dap-vscode-js',
    ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  }
end

return M
