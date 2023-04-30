local M = {}

-- Disable default mappings
-- vim.g.open_url_default_mappings = 0

M.setup = function()
  return {
    'dhruvasagar/vim-open-url',
    keys = {
      'g',
    },
  }
end

return M
