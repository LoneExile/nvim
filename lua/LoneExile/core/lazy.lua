local M = {}
M.setup = function(root)
  local set_loc = '.core.settings'
  local settings = require(root .. set_loc).setup(root, set_loc)

  -----------------------------------------------------
  -----------------------------------------------------
  local lazypath = settings.data_loc .. '/lazy/lazy.nvim'

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
  -----------------------------------------------------

  local config_location = settings.conf_loc .. '/lua/' .. root
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
      -- NOTE: these folders are not loaded by lazy.nvim
      -- order matters?

      root,
      'core',
      'autocmds',
      'ftplugin',
      'plugins',

      -- LSP
      'settings',
      'servers',

      'utils',
    }
    return not vim.tbl_contains(list, folder_name)
  end, files)

  local plugins = {}

  local all_plugins = require(root .. set_loc .. '.plugins.all')

  for _, file in ipairs(files) do
    local file_name = vim.fn.fnamemodify(file, ':t:r')
    local folder = vim.fn.fnamemodify(file, ':h')
    local folder_name = vim.fn.fnamemodify(folder, ':t')
    local location

    if vim.fn.fnamemodify(folder, ':h') == config_location then
      location = root .. '.' .. folder_name .. '.' .. file_name
      location = vim.fn.substitute(location, '.init', '', 'g')
    else
      location = vim.fn.matchstr(file, root .. [[/.*.lua]])
      location = vim.fn.substitute(location, '/', '.', 'g')
      location = vim.fn.substitute(location, '.init', '', 'g')
      location = vim.fn.substitute(location, '.lua$', '', 'g')
    end

    local plugin_config = require(location)
    local plugin = plugin_config.setup(settings, location)
    if plugin ~= nil then
      for _, p in ipairs(all_plugins) do
        if p[1] == plugin[1] and p[2] == false then
          plugin['enabled'] = false
        elseif p[1] == plugin[1] and p[2] == true then
          plugin['enabled'] = true
        elseif plugin.enabled == nil then
          plugin['enabled'] = false
        end

        if plugin['enabled'] == true and p[1] == plugin[1] then
          if plugin_config.wh_key ~= nil then -- and plugin_config.wh_key.enabled ~= false then
            if plugin_config.wh_key.wh_mappings ~= nil then
              local wh_mappings = plugin_config.wh_key.wh_mappings
              for key, value in pairs(wh_mappings) do
                if settings.wh_mappings.mappings[key] == nil then
                  settings.wh_mappings.mappings[key] = value
                else
                  settings.wh_mappings.mappings[key] =
                    vim.tbl_deep_extend('force', settings.wh_mappings.mappings[key], value)
                end
              end
            end
            if plugin_config.wh_key.wh_m_mappings ~= nil then
              local wh_mappings = plugin_config.wh_key.wh_m_mappings
              for key, value in pairs(wh_mappings) do
                if settings.wh_mappings.m_mappings[key] == nil then
                  settings.wh_mappings.m_mappings[key] = value
                else
                  settings.wh_mappings.m_mappings[key] =
                    vim.tbl_deep_extend('force', settings.wh_mappings.m_mappings[key], value)
                end
              end
            end
          end
          break
        end
      end

      if plugin['enabled'] == true then
        table.insert(plugins, plugin)
      end
      -- table.insert(plugins, plugin)
    end
  end

  -----------------------------------------------------

  --   { 'nvim-lua/plenary.nvim' },
  --   { 'nvim-lua/popup.nvim' },
  --   { 'nvim-tree/nvim-web-devicons' },

  local status, lazy = pcall(require, 'lazy')
  if not status then
    return
  end

  local opts = {
    lockfile = settings['resources'] .. '/lazy-lock.json',
  }

  lazy.setup(plugins, opts)
end

return M
