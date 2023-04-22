local M = {}

M.setup = function(root, m)
  local exclude = { 'settings' }
  m.setup_load(root, exclude)
end

return M
