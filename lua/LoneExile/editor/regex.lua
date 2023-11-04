local M = {}

M.wh_key = {
  wh_mappings = {
    u = {
      name = '+Utility',
      r = {
        '<cmd>Hypersonic<CR>',
        'regex',
        mode = { 'n' },
      },
    },
  },
}

M.setup = function()
  return {

    'tomiis4/Hypersonic.nvim',
    event = 'CmdlineEnter',
    cmd = 'Hypersonic',

    config = function()
      require('hypersonic').setup({
        -- config
      })
    end,
  }
end

return M
