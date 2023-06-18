local M = {}

-- M.wh_key = {
--   wh_mappings = {},
-- }

M.setup = function()
  return {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    config = function()
      require('go').setup()
    end,
  }
end

return M
