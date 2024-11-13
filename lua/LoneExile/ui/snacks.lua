local M = {}

M.setup = function(_, _)
  return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    -- config = true,
    opts = {
      bigfile = { enabled = true },
      notifier = {
        enabled = false,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = false },
      styles = {
        notification = {
          wo = { wrap = false },
        },
      },
    },
  }
end

return M
