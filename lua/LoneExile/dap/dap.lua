local M = {}

M.wh_key = {
  wh_mappings = {
    d = {
      name = 'Debug',
      v = { '<cmd>DapVirtualTextToggle<cr>', 'Toggle virtual text', mode = { 'n' } },
      T = { '<cmd>DapTerminate<cr>', 'Terminate', mode = { 'n' } },
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", 'Toggle Breakpoint', mode = { 'n' } },
      b = { "<cmd>lua require'dap'.step_back()<cr>", 'Step Back', mode = { 'n' } },
      B = {
        "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
        'Breakpoint condition',
        mode = { 'n' },
      },
      l = {
        "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
        'Log point',
        mode = { 'n' },
      },
      L = { "<Cmd>lua require'dap'.run_last()<CR>", 'Run last', mode = { 'n' } },
      c = { "<cmd>lua require'dap'.continue()<cr>", 'Continue', mode = { 'n' } },
      C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", 'Run To Cursor', mode = { 'n' } },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", 'Disconnect', mode = { 'n' } },
      g = { "<cmd>lua require'dap'.session()<cr>", 'Get Session', mode = { 'n' } },
      i = { "<cmd>lua require'dap'.step_into()<cr>", 'Step Into', mode = { 'n' } },
      o = { "<cmd>lua require'dap'.step_over()<cr>", 'Step Over', mode = { 'n' } },
      u = { "<cmd>lua require'dap'.step_out()<cr>", 'Step Out', mode = { 'n' } },
      p = { "<cmd>lua require'dap'.pause()<cr>", 'Pause', mode = { 'n' } },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", 'Toggle Repl', mode = { 'n' } },
      s = { "<cmd>lua require'dap'.continue()<cr>", 'Start', mode = { 'n' } },
      q = { "<cmd>lua require'dap'.close()<cr>", 'Quit', mode = { 'n' } },
    },
  },
}

M.setup = function(settings, location)
  -- settings.utils.setup_mappings('<leader>', M.wh_key.wh_mappings, _)
  return {
    'mfussenegger/nvim-dap',
    lazy = true,
    cmd = { 'DapToggleBreakpoint', 'DapContinue' },
    config = function()
      -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
      local status_ok, dap = pcall(require, 'dap')
      if not status_ok then
        return
      end

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
      require(location .. '.settings.node').setup(dap)
      require(location .. '.settings.csharp').setup(dap)
      require(location .. '.settings.rust').setup(dap)
      -- require(location .. '.settings.go').setup(dap)
    end,
  }
end

return M
