local M = {}

M.setup = function(root, m)
  local exclude = { 'autoRun.lua' }
  m.setup_load(root, exclude)
end

return M
