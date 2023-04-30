local M = {}

M.wh_key = {
  wh_mappings = {
    u = {
      name = '+Utility',
      h = {
        name = 'highlight',
        a = { '<cmd>lua require("hlargs").toggle()<cr>', 'Arguments', mode = { 'n' } },
      },
    },
  },
}

M.setup = function()
  return {
    'm-demare/hlargs.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'BufRead',
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
