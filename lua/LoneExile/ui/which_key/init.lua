local M = {}

M.setup = function(settings, _)
  return {
    'folke/which-key.nvim',
    -- commit = '0099511294f16b81c696004fa6a403b0ae61f7a0',
    keys = settings.wh_mappings,
    event = 'VeryLazy',
    opts = {
      preset = 'modern',
      icons = { mappings = false },
    },
    -- config = function()
    --   -- vim.o.timeout = true
    --   -- vim.o.timeoutlen = 300
    --   local status_ok, which_key = pcall(require, 'which-key')
    --   if not status_ok then
    --     return
    --   end

    --   local config = {
    --     preset = 'modern',
    --     plugins = {
    --       marks = true,
    --       registers = true,
    --       presets = {
    --         operators = true,
    --         motions = true,
    --         text_objects = true,
    --         windows = true,
    --         nav = true,
    --         z = true,
    --         g = true,
    --       },
    --       spelling = { enabled = true, suggestions = 20 },
    --     },
    --     icons = {
    --       breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
    --       separator = '➜', -- symbol used between a key and it's label
    --       group = '+', -- symbol prepended to a group
    --     },
    --     layout = {
    --       height = { min = 4, max = 20 },
    --       width = { min = 20, max = 30 },
    --       spacing = 2,
    --       align = 'left',
    --     },
    --     show_help = false,
    --     triggers = 'auto',
    --     -- triggers = { '<leader>', 'g', 'm' }, -- or specify a list manually
    --     disable = {
    --       -- buftypes = { '*' },
    --       -- filetypes = { '*' },
    --     },
    --   }
  }
end

return M
