local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("packer" .. " not found!")
	return
end

local snapshot_path = vim.fn.expand("$HOME") .. "/.config/nvim/plugin/snapshot/"
packer.init({
	max_jobs = 20,
	snapshot_path = snapshot_path, -- Default save directory for snapshots
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

local pluginTable = require("user.core.plugins")

-- Install your plugins here
return packer.startup(function(use)
	for _, plugin in ipairs(pluginTable) do
		use(plugin)
	end

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
