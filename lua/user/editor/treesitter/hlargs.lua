local M = {}

M.setup = function()
  return {
    'm-demare/hlargs.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VimEnter',
    config = function()
      local status, hlargs = pcall(require, 'hlargs')
      if not status then
        return
      end

      hlargs.setup({
        color = '#FF69B4',
      })
    end,
  }
end

return M
