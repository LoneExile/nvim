
-- TODO: check files exist before  require
local M = {
  config_location = vim.fn.stdpath('config') .. '/lua/user',
  tranparent = true,
  theme = 'tokyonight-storm',

  ------------------------------------------------------------------
  env_file = require('user.utils.init_env'),
  colors = require('user.core.settings.colors'),
  kindIcon = require('user.core.settings.kind').kindIcon,
  kind_icons = require('user.core.settings.kind').kind_icons,
  wh_mappings = require('user.core.settings.wh_mappings'),
}

return M
