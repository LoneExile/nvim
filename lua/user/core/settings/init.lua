-- TODO: check files exist before  require

local settings_path = 'user.core.settings.'
local colors = require(settings_path .. 'colors')

local M = {
  config_location = vim.fn.stdpath('config') .. '/lua/user',
  tranparent = true,
  theme = 'tokyonight-storm',

  ------------------------------------------------------------------
  env_file = 'user.utils.init_env',
  colors = colors,
  kindIcon = require(settings_path .. 'kind').kindIcon(colors),
  kind_icons = require(settings_path .. 'kind').kind_icons,
  wh_mappings = require(settings_path .. 'wh_mappings'),
}

return M
