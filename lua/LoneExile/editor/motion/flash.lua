local M = {}

-- flash.nvim — modern motion plugin replacing phaazon/hop.nvim (abandoned).
-- Preserves the user's `gh` muscle memory by mapping it to flash.jump.
-- Adds flash's standard `s`/`S` and `r`/`R` defaults too.

M.keys = {
  {
    'gh',
    function() require('flash').jump() end,
    desc = 'Flash jump (was HopWord)',
    mode = { 'n', 'x', 'o' },
  },
  {
    's',
    function() require('flash').jump() end,
    desc = 'Flash jump',
    mode = { 'n', 'x', 'o' },
  },
  {
    'S',
    function() require('flash').treesitter() end,
    desc = 'Flash treesitter select',
    mode = { 'n', 'x', 'o' },
  },
  {
    'r',
    function() require('flash').remote() end,
    desc = 'Flash remote',
    mode = 'o',
  },
  {
    'R',
    function() require('flash').treesitter_search() end,
    desc = 'Flash treesitter search',
    mode = { 'o', 'x' },
  },
}

M.setup = function()
  return {
    'folke/flash.nvim',
    event = 'BufRead',
    keys = M.keys,
    ---@type Flash.Config
    opts = {
      -- The label keys flash uses to label jump targets — preserves the
      -- old hop.nvim ergonomics ("etovxqpdygfblzhckisuran" weighted by
      -- finger reach on QWERTY).
      labels = 'etovxqpdygfblzhckisuran',
      modes = {
        char = {
          enabled = true, -- f/F/t/T motions get flash labels
        },
        search = {
          enabled = false, -- don't intercept `/` and `?`
        },
      },
    },
  }
end

return M
