local status_ok_ui, lsp = pcall(require, "lsp-zero")
if not status_ok_ui then
	return
end

local luadev = require("lua-dev").setup({
	library = {
		enabled = true, -- when not enabled, lua-dev will not change any settings to the LSP server
		-- these settings will be used for your Neovim config directory
		runtime = true, -- runtime path
		types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
		plugins = true, -- installed opt or start plugins in packpath
		-- you can also specify the list of plugins to make available as a workspace library
		-- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
	},
	setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
	-- for your Neovim config directory, the config.library settings will be used as is
	-- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
	-- for any other directory, config.library.enabled will be set to false

	-- override = function(root_dir, options) end,

	override = function(root_dir, library)
		if require("lua-dev.util").has_file(root_dir, "/etc/nixos") then
			library.enabled = true
			library.plugins = true
		end
	end,
})
lsp.configure("sumneko_lua", luadev)
-- lsp.configure("sumneko_lua", {
-- 	settings = {
-- 		Lua = {
-- 			completion = {
-- 				callSnippet = "Replace",
-- 			},
-- 			diagnostics = {
-- 				globals = { "vim" },
-- 			},
-- 			telemetry = { enable = false },
-- 		},
-- 	},
-- 	-- on_attach = function(client, bufnr)
-- 	-- 	print("hello tsserver")
-- 	-- end,
-- })
