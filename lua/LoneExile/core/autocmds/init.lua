local M = {}

M.setup = function(root, m)
  local exclude = { 'autoRun.lua', 'line_number.lua' }
  m.setup_load(root, exclude)
end

return M
