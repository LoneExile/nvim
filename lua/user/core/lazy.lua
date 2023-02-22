local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------
local root = 'user'
local settings = require(root .. '.core.settings')

local config_location = vim.fn.stdpath('config') .. '/lua/' .. root
local all_files = vim.fn.glob(config_location .. '/**/*.lua', true, true)
local files = vim.tbl_filter(function(file)
  return not vim.endswith(file, 'lazy.lua') and not vim.startswith(file, '_')
end, all_files)

files = vim.tbl_filter(function(file)
  local folder = vim.fn.fnamemodify(file, ':h')
  local init_file = folder .. '/init.lua'
  if vim.fn.filereadable(init_file) == 1 then
    return vim.endswith(file, 'init.lua')
  end
  return true
end, files)

files = vim.tbl_filter(function(file)
  local folder = vim.fn.fnamemodify(file, ':h')
  local folder_name = vim.fn.fnamemodify(folder, ':t')
  local list = {
    'utils',
    'autoCmd',
    'core',
    'keymaps',
    -- 'servers',
    'settings',
    -- 'which-key',
  }
  return not vim.tbl_contains(list, folder_name)
end, files)

local plugins = {}

for _, file in ipairs(files) do
  local file_name = vim.fn.fnamemodify(file, ':t:r')
  local folder = vim.fn.fnamemodify(file, ':h')
  local folder_name = vim.fn.fnamemodify(folder, ':t')
  local location

  if vim.fn.fnamemodify(folder, ':h') == config_location then
    location = 'user.' .. folder_name .. '.' .. file_name
    location = vim.fn.substitute(location, '.init', '', 'g')
    -- print('1: ', location)
  else
    location = vim.fn.matchstr(file, [[user/.*.lua]])
    location = vim.fn.substitute(location, '/', '.', 'g')
    location = vim.fn.substitute(location, '.init', '', 'g')
    location = vim.fn.substitute(location, '.lua$', '', 'g')
    -- print('2:', location)
  end

  local plugin_config = require(location) --.setup(settings, location)
  table.insert(plugins, plugin_config.setup(settings, location))

  if plugin_config.wh_key ~= nil and plugin_config.wh_key.enabled ~= false then
    if plugin_config.wh_key.wh_mappings ~= nil then
      local wh_mappings = plugin_config.wh_key.wh_mappings
      table.insert(settings.wh_mappings.mappings, wh_mappings)
    end
    if plugin_config.wh_key.wh_m_mappings ~= nil then
      local wh_mappings = plugin_config.wh_key.wh_m_mappings
      table.insert(settings.wh_mappings.m_mappings, wh_mappings)
    end
  end
end

-- print(vim.inspect(settings.wh_mappings.mappings))
-- table.insert(plugins, require('user.ui.which_key').setup(settings, 'user.ui.which_key'))
-----------------------------------------------------

--   { 'nvim-lua/plenary.nvim' },
--   { 'nvim-lua/popup.nvim' },
--   { 'nvim-tree/nvim-web-devicons' },

local status, lazy = pcall(require, 'lazy')
if not status then
  return
end

local opts = {
  lockfile = vim.fn.stdpath('config') .. '/resources/lazy-lock.json',
}

lazy.setup(plugins, opts)
