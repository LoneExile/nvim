
-- local lsp_formatting = function(bufnr)
--   vim.lsp.buf.format({
--     filter = function(client)
--       return client.name == 'null-ls'
--     end,
--     bufnr = bufnr,
--   })
--   -- require("user.utils.format").format({
--   -- 	filter = function(client)
--   -- 		return client.name == "null-ls"
--   -- 	end,
--   -- 	bufnr = bufnr,
--   -- })
-- end

-- local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

-- local on_attach = function(client, bufnr)
--   -- if client.name ~= "null-ls" then
--   -- 	client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
--   -- end
--   if client.supports_method('textDocument/formatting') then
--     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--     vim.api.nvim_create_autocmd('BufWritePre', {
--       group = augroup,
--       buffer = bufnr,
--       callback = function()
--         lsp_formatting(bufnr)
--       end,
--     })
--     -- vim.api.nvim_create_user_command("SaveNFormat", function()
--     -- 	lsp_formatting(bufnr)
--     -- 	vim.cmd("w!")
--     -- end, {})
--     -- vim.api.nvim_create_user_command("FormatCurrentBuf", function()
--     -- 	lsp_formatting(bufnr)
--     -- end, {})
--   end
-- end
