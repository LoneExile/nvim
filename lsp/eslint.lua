-- Note: on_attach removed - functions cannot be serialized with vim.lsp.enable()
-- The EslintFixAll on save should be handled via the global on_attach in lsp/init.lua
-- or through a buffer-local autocommand when eslint attaches
return {}
