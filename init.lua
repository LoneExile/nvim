-- check requirements
require('user.core.packer')
require('user.utils.requirements')

------------------------------------------------------------------
require('user.utils.autoCmd')
require('user.core')
require('user.lsp')
require('user.dap')
require('user.editor')
require('user.ui')
---------------------------------

-- TODO PERF FIX WARNING HACK NOTE

-- TODO: remaps which-key when i change filetypes

-- FIX: startup time

-- WARNING: formatting not from null-ls will remove mark on format

-- NOTE: TS-Textobject plugin not work like `di,` use targets.vim instead (remove config file?)
