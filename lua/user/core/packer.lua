local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/'
local snapshot_path = vim.fn.expand('$HOME') .. '/.config/nvim/plugin/snapshot/'

local os = vim.loop.os_uname().sysname
if os == 'windows' or os == 'windows_nt' then
  -- TODO: test this is right path or use this? -- vim.fn.stdpath('config')
  snapshot_path = vim.fn.expand('$HOME') .. '\\AppData\\Local\\nvim\\plugin\\snapshot\\'
end

local pluginTable = require('user.core.plugins')
local M = {}
if fn.empty(fn.glob(install_path .. 'packer.nvim')) > 0 then
  M.PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path .. 'packer.nvim',
  })
  vim.cmd([[packadd packer.nvim]])
  print('Syncing plugins...')
end

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  vim.notify('packer' .. ' not found!')
  return
end

packer.init({
  max_jobs = 20,
  snapshot_path = snapshot_path, -- Default save directory for snapshots
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
})

packer.startup(function(use)
  for _, plugin in ipairs(pluginTable) do
    use(plugin)
  end

  if M.PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

return M

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])
