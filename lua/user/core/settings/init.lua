local M = {}

M.setup = function(root, set_loc)
  local settings_path = root .. set_loc .. '.'
  local colors = require(settings_path .. 'colors')
  local settings = {
    root = root,
    theme = 'tokyonight-storm',
    tranparent = true,

    ------------------------------------------------------------------
    colors = colors,
    kindIcon = require(settings_path .. 'kind').kindIcon(colors),
    kind_icons = require(settings_path .. 'kind').kind_icons,
    wh_mappings = require(settings_path .. 'wh_mappings').setup(root),
  }
  return settings
end

return M
