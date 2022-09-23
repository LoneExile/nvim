-- TODO move this to utils
local M = {}
function M.format(opts)
	opts = opts or {}
	opts.filter = opts.filter or M.format_filter

	if vim.lsp.buf.format then
		return vim.lsp.buf.format(opts)
	end

	local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()

	---@type table|nil
	local clients = vim.lsp.get_active_clients({
		id = opts.id,
		bufnr = bufnr,
		name = opts.name,
	})

	if opts.filter then
		clients = vim.tbl_filter(opts.filter, clients)
	end

	clients = vim.tbl_filter(function(client)
		return client.supports_method("textDocument/formatting")
	end, clients)

	if #clients == 0 then
		vim.notify_once("[LSP] Format request failed, no matching language servers.")
	end

	local timeout_ms = opts.timeout_ms or 1000
	for _, client in pairs(clients) do
		local params = vim.lsp.util.make_formatting_params(opts.formatting_options)
		local result, err = client.request_sync("textDocument/formatting", params, timeout_ms, bufnr)
		if result and result.result then
			vim.lsp.util.apply_text_edits(result.result, bufnr, client.offset_encoding)
		elseif err then
			vim.notify(string.format("[LSP][%s] %s", client.name, err), vim.log.levels.WARN)
		end
	end
end

-- ---filter passed to vim.lsp.buf.format
-- ---always selects null-ls if it's available and caches the value per buffer
-- ---@param client table client attached to a buffer
-- ---@return boolean if client matches
function M.format_filter(client)
	local filetype = vim.bo.filetype
	local n = require("null-ls")
	local s = require("null-ls.sources")
	local method = n.methods.FORMATTING
	local avalable_formatters = s.get_available(filetype, method)

	if #avalable_formatters > 0 then
		return client.name == "null-ls"
	elseif client.supports_method("textDocument/formatting") then
		return true
	else
		return false
	end
end

return M
