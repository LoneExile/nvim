local M = {}

M.setup = function(root, m)
  local exclude = { 'autoRun.lua' }
  m.setup_load(root, exclude)
end

vim.keymap.set('x', 'i', function()
  if #vim.fn.getline('.') == 0 then
    return [["_cc]]
  else
    return 'i'
  end
end, { expr = true })

return M
