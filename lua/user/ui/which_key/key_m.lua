local M = {}

M.m_opts = {
  mode = 'n', -- NORMAL mode
  prefix = 'm',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

M.m_mappings = {
  m = { '<cmd>lua require("harpoon.mark").add_file()<cr>', 'Harpoon' },
  ['j'] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', 'Harpoon Next' },
  ['k'] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', 'Harpoon Prev' },
  s = { '<cmd>Telescope harpoon marks<cr>', 'Search Files' },
  [';'] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', 'Harpoon UI' },
}

return M
