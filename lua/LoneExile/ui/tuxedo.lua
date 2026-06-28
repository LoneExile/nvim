local M = {}

M.keys = {
  {
    '<leader>T',
    '<cmd>Tuxedo<CR>',
    desc = 'Tuxedo',
    mode = 'n',
  }
}

M.setup = function(_, _)
  return {
    'IogaMaster/tuxedo.nvim',
    cmd = { 'Tuxedo' },
    keys = M.keys,
    priority = 1000,
    lazy = true, -- not the active theme; load on demand via `:colorscheme tuxedo`
    opts = {},
  }
end

return M
