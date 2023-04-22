local M = {}

M.setup = function()
  local status, cmpLSP = pcall(require, 'cmp_nvim_lsp')
  if not status then
    return
  end

  return {
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = cmpLSP.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client, bufnr) -- bufnr
      -- NOTE: this create exec autocommands to trigger LspAttached to add keybindings
      -- vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
      -- add_lsp_buffer_keybindings(bufnr)

      if client.name == 'eslint' then
        client.server_capabilities.documentFormattingProvider = true
      end

      -----------------------------------------------------------------------------------
      local status_ok, navic = pcall(require, 'nvim-navic')
      if not status_ok then
        return
      end
      navic.attach(client, bufnr)
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

      local status_navbuddy, navbuddy = pcall(require, 'nvim-nvim-navbuddy')
      if status_navbuddy then
        navbuddy.attach(client, bufnr)
      end
      -----------------------------------------------------------------------------------
    end,
  }
end

return M
