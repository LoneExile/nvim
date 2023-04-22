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
  local file_path = path and path:match('lua/(.+)') or nil
  return file_path
end

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

M.setup = function()
  M.load_config(M.core)
end

M.core = { 'core' }

M.get_files_in_dir = function(dir)
  local files = vim.fn.glob(dir .. '/*', false, true)
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

M.clean_path = function(files, exclude_list, root)
  local paths = {}
  local replacements = {
    { search = '/', replace = '.' },
    { search = '%.lua$', replace = '' },
    { search = '^' .. root .. '%.', replace = '' },
  }

  for _, file in ipairs(files) do
    local path = file:match('nvim/lua/(.+)')
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
  current_loc = vim.fn.fnamemodify(current_loc, ':h')
  local files = M.get_files_in_dir(current_loc)
  files = M.clean_path(files, exclude, root)

  require(root).load_config(files)
end

return M
