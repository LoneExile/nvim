--------------------------------------------------------------
local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
	return
end

impatient.enable_profile()

-------------------------------------------------------------
-- in millisecond, used for both CursorHold and CursorHoldI,
-- use updatetime instead if not defined

vim.g["cursorhold_updatetime"] = 100

------------------------------------------------------------
--disable_distribution_plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
