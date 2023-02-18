local M = {}

local mason_path = vim.fn.glob(vim.fn.stdpath('data') .. '/mason/')
local codelldb_adapter = {
  type = 'server',
  port = '${port}',
  executable = {
    command = mason_path .. 'bin/codelldb',
    args = { '--port', '${port}' },
    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}

-- TODO: check is this works on windows
local CURRENTOS = require('user.utils.requirements').CURRENTOS
if CURRENTOS == 'windows' or CURRENTOS == 'windows_nt' then
  local detached = { detach = false }
  table.insert(codelldb_adapter.executable, detached)
end

function M.setup(dap)
  dap.adapters.codelldb = codelldb_adapter
  dap.configurations.rust = {
    {
      name = 'Launch file',
      type = 'codelldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
    },
  }
end

return M
