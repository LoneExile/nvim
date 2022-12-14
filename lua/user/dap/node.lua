local status, dapVSCode = pcall(require, 'dap-vscode-js')
if not status then
  return
end

local M = {}

function M.setup(dap)
  dapVSCode.setup({
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    debugger_path = vim.fn.glob(vim.fn.stdpath('data') .. '/mason/') .. 'bin/js-debug-adapter', -- Path to vscode-js-debug installation.
    debugger_cmd = { 'js-debug-adapter' }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  })

  for _, language in ipairs({ 'typescript', 'javascript' }) do
    dap.configurations[language] = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
        -- args = {},
      },
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach',
        processId = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
      },
      -- {
      --   type = 'pwa-chrome',
      --   request = 'launch',
      --   name = 'Launch Chrome',
      -- },
    }
  end
end

return M
