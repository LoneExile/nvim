local M = {}

M.g_opts = {
  mode = 'n', -- NORMAL mode
  prefix = 'g',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

M.g_mappings = {}

return M
