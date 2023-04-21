local M = {}

M.setup = function(root)
  local _, main = pcall(require, root)
  local current_loc = main.get_current_script_path()

  -- used to remove the last path component (the file or directory name)
  current_loc = vim.fn.fnamemodify(current_loc, ':h')

  local exclude = { 'settings' }
  local files = main.get_files_in_dir(current_loc)
  files = main.clean_path(files, exclude)

  require(root).load_config(files)
end

return M
