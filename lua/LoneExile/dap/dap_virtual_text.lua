local M = {}

M.wh_key = {
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
    lazy = true,
    -- event = { 'BufReadPre', 'InsertEnter' },
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('nvim-dap-virtual-text').setup({})
    end,
  }
end

return M
