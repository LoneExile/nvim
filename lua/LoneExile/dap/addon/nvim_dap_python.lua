local M = {}

M.setup = function(s, _)
  return {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    ft = { 'python' },
    config = function()
      local debug_adapter = s.utils.convert_path(vim.fn.glob(s.data_loc .. '/mason/') .. 'packages/debugpy/venv/bin/python3')
      require('dap-python').setup(debug_adapter)
    end,
  }
end

return M
