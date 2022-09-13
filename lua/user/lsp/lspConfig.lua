local status_ok_ui, lsp = pcall(require, "lsp-zero")
if not status_ok_ui then
	return
end

local buffer_mappings = {
	normal_mode = {
		["K"] = { "<cmd>Lspsaga hover_doc<CR>", "Show hover" },
		["gd"] = { "<cmd>Lspsaga peek_definition<CR>", "Goto Definition" },
		["gs"] = { vim.lsp.buf.signature_help, "show signature help" },
		["gr"] = { "<cmd>Lspsaga lsp_finder<CR>", "Goto references" },
		["gR"] = { "<cmd>Lspsaga rename<CR>", "rename" },
		["gq"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
		["gj"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next diagnostic" },
		["gk"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev diagnostic" },
		["gD"] = { vim.lsp.buf.declaration, "Goto declaration" },
		["gI"] = { vim.lsp.buf.implementation, "Goto Implementation" },
		["gp"] = {
			function()
				require("lvim.lsp.peek").Peek("definition")
			end,
			"Peek definition",
		},
		["gl"] = {
			"<cmd>Lspsaga show_line_diagnostics<cr>",
			-- function()
			--   local config = lvim.lsp.diagnostics.float
			--   config.scope = "line"
			--   vim.diagnostic.open_float(0, config)
			-- end,
			"Show line diagnostics",
		},
	},
	insert_mode = {},
	visual_mode = {
		["gq"] = { "<Esc><cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
	},
}

local function add_lsp_buffer_keybindings(bufnr)
	local mappings = {
		normal_mode = "n",
		insert_mode = "i",
		visual_mode = "v",
	}
	for mode_name, mode_char in pairs(mappings) do
		for key, remap in pairs(buffer_mappings[mode_name]) do
			local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
			vim.keymap.set(mode_char, key, remap[1], opts)
		end
	end
end

lsp.on_attach(function(client, bufnr)
	add_lsp_buffer_keybindings(bufnr)
end)
--------------------------------------------------------------------------
-- local opts = { noremap = true, silent = true }
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- -- Use an on_attach function to only map the following keys
-- -- after the language server attaches to the current buffer
-- local on_attach = function(client, bufnr)
-- 	-- Enable completion triggered by <c-x><c-o>
-- 	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

-- 	local bufopts = { noremap = true, silent = true, buffer = bufnr }
-- 	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
-- 	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
-- 	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
-- 	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
-- 	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
-- 	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
-- 	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
-- 	vim.keymap.set("n", "<space>wl", function()
-- 		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- 	end, bufopts)
-- 	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
-- 	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
-- 	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
-- 	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
-- 	vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)
-- end

-- local lsp_flags = {
-- 	debounce_text_changes = 150,
-- }
-- require("lspconfig")["pyright"].setup({
-- 	on_attach = on_attach,
-- 	flags = lsp_flags,
-- })
-- require("lspconfig")["tsserver"].setup({
-- 	on_attach = on_attach,
-- 	flags = lsp_flags,
-- })
-- require("lspconfig")["sumneko_lua"].setup({
-- 	on_attach = on_attach,
-- 	flags = lsp_flags,
-- })
