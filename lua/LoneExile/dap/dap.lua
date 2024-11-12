local M = {}

M.keys = {
  {
    '<leader>d',
    desc = 'Debug',
    mode = 'n',
  },
  {
    '<leader>dv',
    '<cmd>DapVirtualTextToggle<cr>',
    desc = 'Toggle virtual text',
    mode = 'n',
  },
  {
    '<leader>dT',
    '<cmd>DapTerminate<cr>',
    desc = 'Terminate',
    mode = 'n',
  },
  {
    '<leader>dt',
    "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
    desc = 'Toggle Breakpoint',
    mode = 'n',
  },
  {
    '<leader>db',
    "<cmd>lua require'dap'.step_back()<cr>",
    desc = 'Step Back',
    mode = 'n',
  },
  {
    '<leader>dB',
    "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
    desc = 'Breakpoint condition',
    mode = 'n',
  },
  {
    '<leader>dl',
    "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
    desc = 'Log point',
    mode = 'n',
  },
  {
    '<leader>dL',
    "<Cmd>lua require'dap'.run_last()<CR>",
    desc = 'Run last',
    mode = 'n',
  },
  {
    '<leader>dc',
    "<cmd>lua require'dap'.continue()<cr>",
    desc = 'Continue',
    mode = 'n',
  },
  {
    '<leader>dC',
    "<cmd>lua require'dap'.run_to_cursor()<cr>",
    desc = 'Run To Cursor',
    mode = 'n',
  },
  {
    '<leader>dd',
    "<cmd>lua require'dap'.disconnect()<cr>",
    desc = 'Disconnect',
    mode = 'n',
  },
  {
    '<leader>dg',
    "<cmd>lua require'dap'.session()<cr>",
    desc = 'Get Session',
    mode = 'n',
  },
  {
    '<leader>di',
    "<cmd>lua require'dap'.step_into()<cr>",
    desc = 'Step Into',
    mode = 'n',
  },
  {
    '<leader>do',
    "<cmd>lua require'dap'.step_over()<cr>",
    desc = 'Step Over',
    mode = 'n',
  },
  {
    '<leader>du',
    "<cmd>lua require'dap'.step_out()<cr>",
    desc = 'Step Out',
    mode = 'n',
  },
  {
    '<leader>dp',
    "<cmd>lua require'dap'.pause()<cr>",
    desc = 'Pause',
    mode = 'n',
  },
  {
    '<leader>dr',
    "<cmd>lua require'dap'.repl.toggle()<cr>",
    desc = 'Toggle Repl',
    mode = 'n',
  },
  {
    '<leader>ds',
    "<cmd>lua require'dap'.continue()<cr>",
    desc = 'Start',
    mode = 'n',
  },
  {
    '<leader>dq',
    "<cmd>lua require'dap'.close()<cr>",
    desc = 'Quit',
    mode = 'n',
  },
}

M.setup = function(s, location)
  return {
    'mfussenegger/nvim-dap',
    lazy = true,
    cmd = { 'DapToggleBreakpoint', 'DapContinue' },
    dependencies = { 'rcarriga/nvim-dap-ui' },
    keys = M.keys,
    config = function()
      -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
      local status_ok, dap = pcall(require, 'dap')
      if not status_ok then
        return
      end

      require('which-key').show({
        keys = '<leader>d',
        loop = true,
      })

      local icons = {
        breakpoint = {
          text = ' ',
          texthl = 'DiagnosticError',
          linehl = '',
          numhl = '',
        },
        breakpoint_rejected = {
          text = '󰃤 ',
          texthl = 'DiagnosticHint',
          linehl = '',
          numhl = '',
        },
        stopped = {
          text = '',
          texthl = 'DiagnosticInfo',
          linehl = 'DiagnosticUnderlineInfo',
          numhl = 'DiagnosticInfo',
        },
        breakpoint_condition = {
          text = '󰨾 ',
          texthl = 'LspSagaDiagnosticBorder',
          linehl = '',
          numhl = '',
        },
      }

      vim.fn.sign_define('DapBreakpoint', icons.breakpoint)
      vim.fn.sign_define('DapBreakpointRejected', icons.breakpoint_rejected)
      vim.fn.sign_define('DapStopped', icons.stopped)
      vim.fn.sign_define('DapBreakpointCondition', icons.breakpoint_condition)
      dap.defaults.fallback.terminal_win_cmd = '50vsplit new'

      location = vim.fn.substitute(location, '.dap.dap', '.dap', 'g')
      require(location .. '.settings.node').setup(dap, s)
      require(location .. '.settings.csharp').setup(dap, s)
      require(location .. '.settings.rust').setup(dap, s)
      -- require(location .. '.settings.go').setup(dap, s)
    end,
  }
end

return M
