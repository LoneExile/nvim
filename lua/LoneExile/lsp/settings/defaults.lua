local M = {}

M.setup = function(capabilities)
  return {
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
    on_attach = function(client, _) -- bufnr
      -- NOTE: this create exec autocommands to trigger LspAttached to add keybindings
      -- vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
      -- add_lsp_buffer_keybindings(bufnr)

      if client.name == 'eslint' then
        client.server_capabilities.documentFormattingProvider = true
      end
    end,
  }
end

return M
