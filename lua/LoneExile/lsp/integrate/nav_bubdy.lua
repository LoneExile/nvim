local M = {}

M.enabled = false

M.setup = function(_, _)
  return {
    'SmiteshP/nvim-navbuddy',
    enabled = M.enabled,
    dependencies = {
      'neovim/nvim-lspconfig',
      'SmiteshP/nvim-navic',
      'MunifTanjim/nui.nvim',
      'numToStr/Comment.nvim', -- Optional
      'nvim-telescope/telescope.nvim', -- Optional
    },
    config = function()
      local status_ok, navbuddy = pcall(require, 'nvim-navbuddy')
      if not status_ok then
        print('Error loading nvim-navbuddy')
        return
      end
      navbuddy.setup({})
    end,
  }
end

return M
