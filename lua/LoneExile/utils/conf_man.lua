local M = {}

M.get_current_script_path = function(stack_level)
  stack_level = stack_level or 2
  local info = debug.getinfo(stack_level, 'S')
  local path = info and info.source:sub(2) or nil
  return path
end

M.get_root_config = function(path)
  local root_config = path and path:match('lua/(.-)/') or nil
  return root_config
end

M.get_current_file_path = function()
  local path = M.get_current_script_path(3)
  local separator = M.get_separator()
  local file_path = path and path:match('lua' .. separator .. '(.+)') or nil
  return file_path
end

M.root = M.get_root_config(M.get_current_script_path())

M.load_config = function(modules)
  local path = M.get_current_script_path()
  local root = M.get_root_config(path)
  for _, module in ipairs(modules) do
    -- print('Loading module: ' .. module)
    local loaded_module = require(root .. '.' .. module)
    local _, _ = pcall(function()
      loaded_module.setup(root, M)
    end)
  end
end

M.setup = function(opts)
  M.opts = opts or {}
  M.load_config(M.core)
  require(M.root .. '.utils.requirements')
end

M.core = { 'core' }

M.get_files_in_dir = function(dir)
  local separator = M.get_separator()
  local files = vim.fn.glob(dir .. separator .. '*', false, true)
  return files
end

M.is_excluded = function(path, exclude_list)
  for _, pattern in ipairs(exclude_list) do
    if path:find(pattern .. '$') then
      return true
    end
  end
  return false
end

M.CURRENTOS = vim.loop.os_uname().sysname
M.get_separator = function()
  if string.lower(M.CURRENTOS) == 'windows' or string.lower(M.CURRENTOS) == 'windows_nt' then
    return '\\'
  else
    return '/'
  end
end

M.clean_path = function(files, exclude_list, root)
  local separator = M.get_separator()
  local replacements = {
    { search = separator, replace = '.' },
    { search = '%.lua$', replace = '' },
    { search = '^' .. root .. '%.', replace = '' },
  }
  local paths = {}

  for _, file in ipairs(files) do
    local path = ''
    if string.lower(M.CURRENTOS) == 'windows' or string.lower(M.CURRENTOS) == 'windows_nt' then
      path = file:match('nvim\\lua\\(.+)')
    else
      path = file:match('nvim/lua/(.+)')
    end
    if not M.is_excluded(path, exclude_list) then
      for _, replacement in ipairs(replacements) do
        path = path:gsub(replacement.search, replacement.replace)
      end
      if not path:match('init$') then -- Exclude files that end with 'init'
        table.insert(paths, path)
      end
    end
  end
  return paths
end

M.setup_load = function(root, exclude)
  local current_loc = M.get_current_script_path(3)
  current_loc = vim.fn.fnamemodify(current_loc, ':h') or ''
  local files = M.get_files_in_dir(current_loc)
  files = M.clean_path(files, exclude, root)

  require(root).load_config(files)
end

--------------------------------------------------------------------
---- Plugins ----
M.get_runtimepath_list = function()
  local runtimepath = vim.o.runtimepath
  local path_list = {}

  for path in runtimepath:gmatch('[^,]+') do
    table.insert(path_list, path)
  end

  return path_list
end

M.get_lazy_plugins = function(data_loc)
  data_loc = data_loc or vim.fn.stdpath('data')
  local paths = M.get_runtimepath_list()
  local lazy_plugins = {}
  local separator = M.get_separator()

  for _, path in ipairs(paths) do
    if path:match('^' .. data_loc .. separator .. 'lazy') then
      local plugin_name = path:gsub(data_loc .. separator .. 'lazy' .. separator, '')
      table.insert(lazy_plugins, plugin_name)
    end
  end
  return lazy_plugins
end

M.is_plugin_loaded = function(data_loc, plugin_name)
  local lazy_plugins = M.get_lazy_plugins(data_loc)

  for _, name in ipairs(lazy_plugins) do
    if name == plugin_name then
      -- print('Plugin ' .. plugin_name .. ' is loaded')
      return true
    end
  end

  -- print('Plugin ' .. plugin_name .. ' is not loaded')
  return false
end
--------------------------------------------------------------------

M.convert_kind_icons = function(kindIcon)
  local kind_icons = {}

  for _, value in ipairs(kindIcon) do
    kind_icons[value[1]] = value[2]
  end
  return kind_icons
end

M.mapping_types = function(mode, lhs, rhs, rhs_type, desc)
  if rhs_type == 'function' then
    vim.api.nvim_set_keymap(mode, lhs, '', { noremap = true, silent = true, callback = rhs, desc = desc })
  elseif rhs_type == 'string' then
    vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
  end
end

M.setup_mappings = function(keyset, mappings, _, prefix)
  prefix = prefix or '' -- initialize prefix to an empty string if not provided
  local _ = _
  for key, mapping in pairs(mappings) do
    -- if mapping.name then
    --   vim.api.nvim_set_keymap('n', keyset .. prefix .. key, _, { desc = mapping.name })
    -- end
    if type(mapping) == 'table' and mapping[1] then
      -- This is a mapping table with a mapping definition
      local lhs = keyset .. prefix .. key
      local rhs = mapping[1]
      local rhs_type = type(rhs)
      local desc = mapping[2]
      local modes = mapping.mode or { 'n' } -- default to 'n' if mode isn't specified
      for _, mode in ipairs(modes) do
        M.mapping_types(mode, lhs, rhs, rhs_type, desc)
      end
    elseif type(mapping) == 'table' then
      -- This is a nested table, recurse with the updated prefix
      M.setup_mappings(keyset, mapping, _, prefix .. key)
    end
  end
end

return M
