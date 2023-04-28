local M = {}

M.setup = function(root, set_loc)
  local set_path = root .. set_loc .. '.'
  local colors = require(set_path .. 'colors')
  local conf_loc = vim.fn.stdpath('config')
  local data_loc = vim.fn.stdpath('data')

  local settings = {
    root = root,
    theme = { plugin = 'folke/tokyonight.nvim', color = 'tokyonight-storm' },
    tranparent = true,
    conf_loc = conf_loc,
    data_loc = data_loc,

    -- TODO: automatically find the resources folder
    resources = conf_loc .. '/resources',

    ------------------------------------------------------------------
    colors = colors,
    kindIcon = require(set_path .. 'kind').kindIcon(colors),
    -- kind_icons = require(set_path .. 'kind').kind_icons,
    wh_mappings = require(set_path .. 'wh_mappings').setup(root),
  }
  return settings
end

return M
