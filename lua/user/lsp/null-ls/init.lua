local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	vim.notify("null_ls" .. " not found!")
	return
end

local hover = null_ls.builtins.hover

local sources = {

	-- hover
	hover.dictionary.with({
		-- filetypes = { "text", "markdown" },
	}),
	hover.printenv.with({
		filetypes = { "bash", "csh", "ksh", "sh", "zsh" },
	}),
}

local formattingTable = require("user.lsp.null-ls.formatting")
local diagnosticsTable = require("user.lsp.null-ls.diagnostics")
local code_actionsTable = require("user.lsp.null-ls.codeAction")
local all = { formattingTable, diagnosticsTable, code_actionsTable }

for _, value in ipairs(all) do
	for _, v in ipairs(value) do
		table.insert(sources, v)
	end
end

-------------------------------------------------------------------------------------------
--https://neovim.discourse.group/t/how-select-server-vim-lsp-buf-format/3098
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end
-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
	-- if client.name ~= "null-ls" then
	-- 	client.server_capabilities.document_formatting = false -- 0.7 and earlier
	-- 	client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
	-- end
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end
-------------------------------------------------------------------------------------------
null_ls.setup({
	on_attach = on_attach,
	sources = sources,
})
