local M = {}

-- NOTE: it's faster than telescope but lacks some features
M.setup = function()
  return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  }
end

return M
