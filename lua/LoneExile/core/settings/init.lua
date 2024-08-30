local M = {}

M.setup = function(root, m)
  -- NOTE: load the environment variables
  require(root .. '.utils.init_env').setup()

  local set_path = m.set_loc .. '.'
  local colors = require(set_path .. 'colors')
  local conf_loc = vim.fn.stdpath('config')
  local data_loc = vim.fn.stdpath('data')

  local settings = {
    root = root,
    theme = { plugin = 'folke/tokyonight.nvim', color = 'tokyonight-storm' },
    transparent = true,
    conf_loc = conf_loc,
    data_loc = data_loc,

    -- TODO: automatically find the resources folder
    resources = conf_loc .. m.get_separator() .. 'resources',

    ------------------------------------------------------------------
    colors = colors,
    kindIcon = require(set_path .. 'kind').kindIcon(colors),
    wh_mappings = require(set_path .. 'wh_mappings').setup(root),
  }
  return settings
end

return M
