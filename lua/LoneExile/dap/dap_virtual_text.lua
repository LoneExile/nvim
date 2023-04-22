local M = {}

M.enabled = true

M.wh_key = {
  enabled = M.enabled,
  wh_mappings = {
    d = {
      name = 'Debug',
      v = { '<cmd>DapVirtualTextToggle<cr>', 'Toggle virtual text', mode = { 'n' } },
    },
  },
}

M.setup = function()
  return {
    'theHamsta/nvim-dap-virtual-text',
    enabled = M.enabled,
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('nvim-dap-virtual-text').setup({})
    end,
  }
end

return M
