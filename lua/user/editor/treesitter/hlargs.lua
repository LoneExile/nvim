local M = {}

M.enabled = true

M.wh_key = {
  enabled = M.enabled,
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
    enabled = M.enabled,
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
