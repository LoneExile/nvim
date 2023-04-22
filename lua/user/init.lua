local M = {}

M.root = function(stack_level)
  stack_level = stack_level or 2
  local info = debug.getinfo(stack_level, 'S')
  local path = info and info.source:sub(2) or nil
  local root_config = path and path:match('lua/(.-)/') or nil
  return root_config
end

M = vim.tbl_extend('force', M, require(M.root() .. '.utils.conf_man'))

M.core = { 'core' }

return M
