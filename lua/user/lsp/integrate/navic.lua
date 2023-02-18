local M = {}

M.setup = function(_, _)
  return {
    { 'SmiteshP/nvim-navic' },
    -- priority = 1,
    -- enabled = false,
    -- dependencies = { 'neovim/nvim-lspconfig' },
    -- config = function()
    --   local status_ok, navic = pcall(require, 'nvim-navic')
    --   if not status_ok then
    --     return
    --   end

    --   -- TODO use utils color
    --   local kindIcon = require(settings.kindIcon)
    --   local iconTable = {}

    --   for _, v in ipairs(kindIcon) do
    --     iconTable[v[1]] = v[2]
    --   end

    --   navic.setup({
    --     icon = iconTable,
    --     highlight = true,
    --     separator = ' >> ',
    --     depth_limit = 0,
    --     depth_limit_indicator = '..',
    --   })

    --   local kind = kindIcon
    --   local prefix = 'NavicIcons'
    --   local group = vim.api.nvim_create_augroup('transparencyTheme', { clear = true })
    --   vim.api.nvim_create_autocmd('ColorScheme', {
    --     pattern = '*',
    --     callback = function()
    --       for _, v in pairs(kind) do
    --         vim.api.nvim_set_hl(0, prefix .. v[1], { fg = v[3], italic = true })
    --       end
    --     end,
    --     group = group,
    --   })
    -- end,
  }
end

return M
