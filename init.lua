-- check requirements
require("user.utils.requirements")
require("user.core.packer")
-- TODO: if nor pass requirements, exit
----------------------------------

require("user.utils.autoCmd")
require("user.core")
require("user.lsp")
require("user.dap")
require("user.editor")
require("user.ui")

---------------------------------
--
-- TODO PERF FIX WARNING HACK NOTE
--
-- TODO: use dressing for better box input
--
-- FIX: startup time

-- WARNING: formatting not from null-ls will remove mark on format

-- HACK:
--
-- NOTE: TS-Textobject plugin not work like `di,` use targets.vim instead (remove config file?)
--
