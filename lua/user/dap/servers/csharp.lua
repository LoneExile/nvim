local M = {}

-- Debugger installation location
local DEBUGGER_LOCATION = vim.fn.glob(vim.fn.stdpath('data') .. '/mason/') .. 'bin/netcoredbg'

function M.setup(dap)
  -- Adapter configuration
  dap.adapters.coreclr = {
    type = 'executable',
    command = DEBUGGER_LOCATION,
    args = { '--interpreter=vscode' },
  }

  -- Configuration
  dap.configurations.cs = {
    {
      type = 'coreclr',
      name = 'launch - netcoredbg',
      request = 'launch',
      program = function()
        -- return vim.fn.input('Path to DLL > ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        return vim.fn.input('Path to DLL > ', vim.fn.getcwd() .. '/', 'file')
      end,
    },
  }
end

return M
