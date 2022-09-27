-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
require('user.dap.dap')

local status_ok, dapPy = pcall(require, 'dap-python')
if not status_ok then
  vim.notify('dap-python' .. ' not found!')
  return
end
dapPy.setup('~/.pyenv/shims/python')

require('nvim-dap-virtual-text').setup({})
require('user.dap.dapUI')
require('user.dap.node')
