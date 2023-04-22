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

M.mappings = {}

return M
