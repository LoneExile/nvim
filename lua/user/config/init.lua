vim.g.python3_host_prog = "$HOME/.pyenv/versions/nvim/bin/python"

require("user.config.impatient")
require("user.config.keymaps").load_defaults()
require("user.config.options")
require("user.config.autoCmd")
require("user.config.notify")
