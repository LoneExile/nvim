local M = {}

M.setup = function()
  return {
    'mfussenegger/nvim-dap-python',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = { 'python' },
    config = function()
      require('dap-python').setup('~/.pyenv/shims/python')
    end,
  }
end

return M
