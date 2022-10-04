local add_lsp_buffer_keybindings = require('user.lsp.settings.keymaps').add_lsp_buffer_keybindings
-- local status_ok, navic = pcall(require, 'nvim-navic')
-- if not status_ok then
--   return
-- end

local status, cmpLSP = pcall(require, 'cmp_nvim_lsp')
if not status then
  return
end

add_lsp_buffer_keybindings()

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = cmpLSP.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
    -- navic.attach(client, bufnr)
    -- add_lsp_buffer_keybindings(bufnr)

    if client.name == 'tsserver' then
      local _, typescript = pcall(require, 'typescript')
      typescript.setup({})
    end

    if client.name == 'eslint' then
      client.server_capabilities.documentFormattingProvider = true
    end
  end,
}

-- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

return lsp_defaults
