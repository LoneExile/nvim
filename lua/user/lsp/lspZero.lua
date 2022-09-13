local status_ok_ui, lsp = pcall(require, "lsp-zero")
if not status_ok_ui then
	return
end

-- lsp.preset("recommended")
-- lsp.setup()

---------------------------------------------------------------------------

-- lsp.preset("lsp-compe")
-- lsp.preset("per-project")

lsp.set_preferences({
	suggest_lsp_servers = true,
	setup_servers_on_start = false,
	set_lsp_keymaps = false,
	configure_diagnostics = true,
	cmp_capabilities = true,
	manage_nvim_cmp = false,
	call_servers = "local",
	sign_icons = {
		error = "✘",
		warn = "▲",
		hint = "⚑",
		info = "",
	},
})

require("user.lsp.lspSetup")
require("user.lsp.mason")
require("user.lsp.lspConfig")
require("user.lsp.cmp")

lsp.setup()
