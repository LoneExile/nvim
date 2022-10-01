local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

local components = require('user.ui.lualine.components')
local theme = require('user.ui.lualine.theme').theme()

lualine.setup({
  options = {
    icons_enabled = true,
    theme = theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'alpha', 'Outline' },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { components.filename },
    lualine_c = { '' },
    lualine_x = {},
    lualine_y = {
      components.treesitter,
      components.lsp,
      components.diagnostics,
      components.diff,
      components.branch,
      components.filetype,
    },
    lualine_z = { 'progress' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { 'neo-tree', 'nerdtree', 'nvim-dap-ui', 'toggleterm' },
})
