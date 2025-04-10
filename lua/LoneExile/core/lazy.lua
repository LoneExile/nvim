local M = {}

M.setup = function(root, m)
  m.set_loc = root .. '.core.settings'
  local settings = require(m.set_loc).setup(root, m)
  settings.utils = m

  M.opts = m.opts or {}
  settings = vim.tbl_extend('force', settings, M.opts)

  local separator = m.get_separator()
  settings.separator = separator

  -----------------------------------------------------
  -----------------------------------------------------

  local lazypath = settings.data_loc .. separator .. 'lazy' .. separator .. 'lazy.nvim'

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

  local config_location = settings.conf_loc .. separator .. 'lua' .. separator .. root
  local all_files = vim.fn.glob(config_location .. separator .. '**' .. separator .. '*.lua', true, true)
  local files = vim.tbl_filter(function(file)
    return not vim.endswith(file, 'lazy.lua') and not vim.startswith(file, '_')
  end, all_files)

  files = vim.tbl_filter(function(file)
    local folder = vim.fn.fnamemodify(file, ':h')
    local init_file = folder .. separator .. 'init.lua'
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

      'dev',

      -- LSP
      'settings',
      'servers',

      'utils',
    }
    return not vim.tbl_contains(list, folder_name)
  end, files)

  local plugins = {}

  local all_plugins = require(m.set_loc .. '.plugins.' .. M.opts.plugin)

  for _, file in ipairs(files) do
    local file_name = vim.fn.fnamemodify(file, ':t:r')
    local folder = vim.fn.fnamemodify(file, ':h')
    local folder_name = vim.fn.fnamemodify(folder, ':t')
    local location

    if vim.fn.fnamemodify(folder, ':h') == config_location then
      location = root .. '.' .. folder_name .. '.' .. file_name
      location = vim.fn.substitute(location, '.init', '', 'g')
    else
      if separator == '\\' then
        location = vim.fn.matchstr(file, root .. [[\\.*.lua]])
        location = vim.fn.substitute(location, '\\', '.', 'g')
      else
        location = vim.fn.matchstr(file, root .. [[/.*.lua]])
        location = vim.fn.substitute(location, '/', '.', 'g')
      end
      if location ~= nil then
        location = vim.fn.substitute(location, '.init', '', 'g')
      end
      if location ~= nil then
        location = vim.fn.substitute(location, '.lua$', '', 'g')
      end
    end

    local plugin_config = require(location)
    local plugin = plugin_config.setup(settings, location)
    if plugin ~= nil then
      for _, p in ipairs(all_plugins) do
        if p[1] == plugin[1] and p[2] == true then
          plugin['enabled'] = true
        end

        if plugin.enabled == nil then
          plugin['enabled'] = false
        end
      end

      if plugin['enabled'] == true then
        table.insert(plugins, plugin)
      end
      -- table.insert(plugins, plugin)
    end
  end

  --   { 'nvim-lua/plenary.nvim' },
  --   { 'nvim-lua/popup.nvim' },
  --   { 'nvim-tree/nvim-web-devicons' },

  local status, lazy = pcall(require, 'lazy')
  if not status then
    return
  end

  local disabled_plugins = {
    'editorconfig', -- A plugin to enforce consistent coding styles using EditorConfig files
    'gzip', -- Support for reading and writing gzip compressed files
    'health', -- A plugin to check the health status of Neovim and its plugins
    'man', -- Support for browsing UNIX manual pages
    'matchit', -- Extended % matching for HTML, LaTeX, and many other languages
    'matchparen', -- Highlight matching pairs of parentheses and other characters
    -- 'netrwPlugin', -- Network-oriented reading, writing, and browsing of files (ftp, scp, etc.)
    'nvim', -- Default Neovim plugin
    'rplugin', -- Remote (RPC) plugin support
    'shada', -- Support for Neovim's ShaDa (shared data) feature
    'spellfile', -- Manage and download spell files for various languages
    'tarPlugin', -- Support for browsing tar archives
    'tohtml', -- Convert the current buffer to HTML with syntax highlighting
    'tutor', -- Interactive tutorial for learning Vim
    'zipPlugin', -- Support for browsing zip archives
  }

  -- :Explorer settings (netrw)
  if M.opts.plugin == 'all' then
    table.insert(disabled_plugins, 'netrwPlugin')
  else
    vim.keymap.set('n', '-', function()
      vim.cmd('Ex')
    end, { desc = 'Explorer' })
    vim.keymap.set('n', '<leader>e', function()
      vim.cmd('Ex')
    end, { desc = 'Explorer' })

    local group = vim.api.nvim_create_augroup('autocmd_netrw', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = {
        'netrw',
      },
      callback = function(event)
        vim.keymap.set('n', '<C-c>', '<CMD>q<CR>', { buffer = event.buf, silent = true })
        vim.keymap.set('n', 'q', '<CMD>q<CR>', { buffer = event.buf, silent = true })
      end,
    })
  end

  local opts = {
    lockfile = settings.resources .. separator .. 'lazy-lock.json',
    -- TODO: currently not working
    -- dev = {
    --   path = settings.conf_loc .. '/lua/' .. root .. '/dev/',
    --   fallback = false, -- Fallback to git when local plugin doesn't exist
    -- },
    performance = {
      rtp = {
        disabled_plugins = disabled_plugins,
      },
    },
  }

  lazy.setup(plugins, opts)
end

return M
