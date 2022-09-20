-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
require("user.dap.dap")
require("dap-python").setup("~/.pyenv/shims/python")
require("nvim-dap-virtual-text").setup({})
require("user.dap.dapUI")
require("user.dap.node")
