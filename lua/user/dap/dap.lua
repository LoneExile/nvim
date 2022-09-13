local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

local icons = {
	breakpoint = {
		text = "",
		texthl = "LspDiagnosticsSignError",
		linehl = "",
		numhl = "",
	},
	breakpoint_rejected = {
		text = "",
		texthl = "LspDiagnosticsSignHint",
		linehl = "",
		numhl = "",
	},
	stopped = {
		text = "",
		texthl = "LspDiagnosticsSignInformation",
		linehl = "DiagnosticUnderlineInfo",
		numhl = "LspDiagnosticsSignInformation",
	},
}

vim.fn.sign_define("DapBreakpoint", icons.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", icons.breakpoint_rejected)
vim.fn.sign_define("DapStopped", icons.stopped)

dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
