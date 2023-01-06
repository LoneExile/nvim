-- check requirements
require('user.core.lazy')
require('user.utils.requirements')

------------------------------------------------------------------
require('user.utils.autoCmd')
require('user.core')
require('user.lsp')
require('user.dap')
require('user.editor')
require('user.ui')

---------------------------------

-- FIX: startup time, restucture plugins by groups (lsps, treesitter, utils, etc)
-- minimal config to run nvim
-- full config to run nvim
-- whichkey better loading time when changing filetypes
