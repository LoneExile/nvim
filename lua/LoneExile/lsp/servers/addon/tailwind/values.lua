local M = {}

M.setup = function()
  return {
    'MaximilianLloyd/tw-values.nvim',
    cmd = { 'TWValues' },
    -- keys = {
    --   { '<leader>sv', '<cmd>TWValues<cr>', desc = 'Show tailwind CSS values' },
    -- },
    opts = {
      border = 'rounded', -- Valid window border style,
      show_unknown_classes = true, -- Shows the unknown classes popup
    },
  }
end

return M
