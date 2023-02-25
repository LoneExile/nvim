local M = {}

M.setup = function(lsp_settings)
  local add_lsp_buffer_keybindings = require(lsp_settings .. '.keymaps').add_lsp_buffer_keybindings

  local status, cmpLSP = pcall(require, 'cmp_nvim_lsp')
  if not status then
    return
  end

  add_lsp_buffer_keybindings()

  return {
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = cmpLSP.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(
      client,
      _ --[[ bufnr ]]
    )
      vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
      -- add_lsp_buffer_keybindings(bufnr)

      -- if client.name == 'tsserver' then
      --   local _, typescript = pcall(require, 'typescript')
      --   typescript.setup({})
      -- end

      if client.name == 'eslint' then
        client.server_capabilities.documentFormattingProvider = true
      end
    end,
  }
  -- return lsp_defaults
end

return M
