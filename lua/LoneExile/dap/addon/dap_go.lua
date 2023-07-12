local M = {}

M.setup = function()
  return {
    'leoluz/nvim-dap-go',
    ft = { 'go' },
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      -- local DEBUGGER_LOCATION = vim.fn.glob(vim.fn.stdpath('data') .. '/mason/') .. 'bin/dlv'
      require('dap-go').setup({
        dap_configurations = {
          {
            type = 'go',
            name = 'Debug (Arguments) <- use this one',
            request = 'launch',
            program = '${file}',
            -- args = get_arguments, -- BUG: not working with stevearc/dressing.nvim
            args = function()
              local args_string = vim.fn.input('Args(split by <space>): ')
              return vim.fn.split(args_string, ' ', true)
            end,
          },
        },
      })
    end,
  }
end

return M
