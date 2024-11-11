local M = {}

M.keys = {
  {
    '<leader>ur',
    '<cmd>Hypersonic<CR>',
    desc = 'regex',
    mode = 'n',
  },

}

M.setup = function()
  return {

    'tomiis4/Hypersonic.nvim',
    event = 'CmdlineEnter',
    cmd = 'Hypersonic',
    keys = M.keys,

    config = function()
      require('hypersonic').setup({
        -- config
      })
    end,
  }
end

return M
