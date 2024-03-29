local M = {}

-- Debugger installation location

function M.setup(dap, s)
  local DEBUGGER_LOCATION = s.utils.convert_path(vim.fn.glob(vim.fn.stdpath('data') .. '/mason/') .. 'bin/netcoredbg')
  -- Adapter configuration
  dap.adapters.coreclr = {
    type = 'executable',
    command = DEBUGGER_LOCATION,
    args = { '--interpreter=vscode' },
  }
  dap.adapters.netcoredbg = {
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
        return vim.fn.input('Path to DLL > ', vim.fn.getcwd() .. s.separator, 'file')
      end,
    },
  }
end

return M
