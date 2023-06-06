local M = {}

-- Disable default mappings
-- vim.g.open_url_default_mappings = 0

M.setup = function()
  return {
    'dhruvasagar/vim-open-url',
    event = 'BufRead',
    keys = {
      -- 'g', -- BUG: this makes the which_key `g` not load properly
      '<leader>',
    },
  }
end

return M
