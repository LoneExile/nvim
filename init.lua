require("user.packer.plugins")

-- setting
require("user.config")
require("user.config.whichKey").setup()

-- language server & debugger
require("user.lsp")
require("user.dap")

-- treesitter
require("user.treesitter")

-- utility
require("user.swissKnife")

-- UI
require("user.UI")
