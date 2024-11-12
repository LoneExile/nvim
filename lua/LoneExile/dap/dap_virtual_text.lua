local M = {}

M.keys = {
  {
    '<leader>dv',
    '<cmd>DapVirtualTextToggle<cr>',
    desc = 'Toggle virtual text',
    mode = 'n',
  },
}

M.setup = function(_, _)
  return {
    'theHamsta/nvim-dap-virtual-text',
    cmd = { 'DapVirtualTextToggle' },
    -- event = { 'BufReadPre', 'InsertEnter' },
    dependencies = { 'mfussenegger/nvim-dap' },
    keys = M.keys,
    config = function()
      require('nvim-dap-virtual-text').setup({
        enabled = true,
      })
    end,
  }
end

return M
