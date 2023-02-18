local M = {}

M.setup = function(_, _)
  return {
    'williamboman/mason-lspconfig.nvim',
    -- enabled = false,
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      local status, mason_lspconfig = pcall(require, 'mason-lspconfig')
      if not status then
        print('mason-lspconfig not installed')
        return
      end

      mason_lspconfig.setup({
        automatic_installation = false,
        ensure_installed = {},
      })
    end,
  }
end

return M
