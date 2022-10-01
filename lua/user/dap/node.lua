-- local dap = require('dap')
-- -- jsnode_dbg
--
-- dap.adapters.node2 = {
--   type = 'executable',
--   command = 'node',
--   args = {
--     vim.fn.stdpath('data') .. '/dapinstall/jsnode_dbg/' .. '/vscode-node-debug2/out/src/nodeDebug.js',
--   },
-- }
--
-- dap.configurations.javascript = {
--   {
--     type = 'node2',
--     request = 'launch',
--     program = '${workspaceFolder}/${file}',
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = 'inspector',
--     console = 'integratedTerminal',
--   },
-- }

-----------------------------------------------------------------------------------------------------------------------------------
local status, dapVSCode = pcall(require, 'dap-vscode-js')
if not status then
  return
end

local status_dap, dap = pcall(require, 'dap')
if not status_dap then
  return
end

dapVSCode.setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
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
