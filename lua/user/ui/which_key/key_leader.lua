local M = {}

M.opts = {
  mode = 'n',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

M.vopts = {
  mode = 'v',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

M.mappings = {
  -- ['e'] = {
  --   '<cmd>Neotree action=focus source=filesystem position=right toggle=true<CR>',
  --   -- function()
  --   -- 	vim.cmd("Neotree position=float toggle=true")
  --   -- end,
  --   'Explorer',
  --   mode = { 'n' },
  -- },
  -- [';'] = {
  --   '<cmd>Alpha<CR>',
  --   'Dashboard',
  --   mode = { 'n' },
  -- },
  -- ['w'] = {
  --   '<cmd>SaveNFormat<CR>',
  --   'Save',
  --   mode = { 'n' },
  --   ft = { only = {}, exclude = { 'alpha', 'neo-tree' } },
  -- },
  -- ['q'] = {
  --   "<cmd>lua require('user.utils.quit').smart_quit()<CR>",
  --   'Quit',
  --   mode = { 'n' },
  -- },
  -- ['/'] = {
  --   cmd = {
  --     n = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
  --     v = '<Plug>(comment_toggle_linewise_visual)',
  --   },
  --   'Comment',
  --   mode = { 'n', 'v' },
  --   ft = { only = {}, exclude = { 'alpha', 'neo-tree' } },
  -- },

  -- ['c'] = {
  --   "<cmd>lua require('user.utils.bufKill').buf_kill()<CR>",
  --   'Close Buffer',
  --   mode = { 'n' },
  -- },
  -- ['H'] = {
  --   '<cmd>nohlsearch<CR>',
  --   'No Highlight',
  --   mode = { 'n' },
  -- },
}

return M
