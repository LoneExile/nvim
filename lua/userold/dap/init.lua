-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
local status_ok, dap = pcall(require, 'dap')
if not status_ok then
  return
end

require('user.dap.dap').setup(dap)
require('user.dap.dapUI').setup(dap)
require('user.dap.node').setup(dap)
require('user.dap.csharp').setup(dap)
require('user.dap.rust').setup(dap)
