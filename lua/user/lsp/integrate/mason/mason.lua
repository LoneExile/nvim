local M = {}

M.setup = function(_, _)
  return {
    'williamboman/mason.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      local status_ok, mason = pcall(require, 'mason')
      if not status_ok then
        print('mason.nvim not installed')
        return
      end
      mason.setup({
        ui = {
          border = 'rounded',
        },
      })
    end,
  }
end

return M
