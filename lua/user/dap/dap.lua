local status_ok, dap = pcall(require, 'dap')
if not status_ok then
  return
end

local icons = {
  breakpoint = {
    text = '',
    -- texthl = 'LspDiagnosticsSignError',
    texthl = 'LspSagaDiagnosticError',
    linehl = '',
    numhl = '',
  },
  breakpoint_rejected = {
    text = '',
    -- texthl = 'LspDiagnosticsSignHint',
    texthl = 'LspSagaDiagnosticHint',
    linehl = '',
    numhl = '',
  },
  stopped = {
    text = '',
    -- texthl = 'LspDiagnosticsSignInformation',
    -- numhl = 'LspDiagnosticsSignInformation',
    texthl = 'LspSagaDiagnosticInfo',
    linehl = 'DiagnosticUnderlineInfo',
    numhl = 'LspSagaDiagnosticInfo',
  },
  breakpoint_condition = {
    text = '',
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
