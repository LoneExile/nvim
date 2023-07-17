local M = {}

function M.setup(dap)
  local debugger_path = vim.fn.glob(vim.fn.stdpath('data') .. '/mason/') .. '/packages/js-debug-adapter/js-debug/src/dapDebugServer.js'

  dap.adapters['pwa-node'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = { debugger_path, '${port}' },
    },
  }

  for _, language in ipairs({ 'typescript', 'javascript' }) do
    dap.configurations[language] = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach',
        processId = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
      },
    }
  end
end

return M
