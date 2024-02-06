local M = {}

function M.setup(dap, s)
  -- Debugger installation location
  local DEBUG_ADAPTER =
    s.utils.convert_path(vim.fn.glob(vim.fn.stdpath('data') .. '/mason/') .. 'packages/go-debug-adapter/extension/dist/debugAdapter.js')
  local DEBUGGER_LOCATION = s.utils.convert_path(vim.fn.glob(vim.fn.stdpath('data') .. '/mason/') .. 'bin/dlv')

  dap.adapters.go = {
    type = 'executable',
    command = 'node',
    args = { DEBUG_ADAPTER },
  }
  dap.configurations.go = {
    {
      type = 'go',
      name = 'Debug',
      request = 'launch',
      showLog = false,
      program = '${file}',
      dlvToolPath = DEBUGGER_LOCATION,
    },
    {
      type = 'go',
      name = 'Debug Package (Arguments)',
      request = 'launch',
      program = '${fileDirname}',
      dlvToolPath = DEBUGGER_LOCATION,
      args = function()
        local args_string = vim.fn.input('Args(split by <space>): ')
        return vim.fn.split(args_string, ' ', true)
      end,
    },
  }
end

return M
