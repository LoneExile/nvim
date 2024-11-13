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
      show_help = false,
      triggers = {
        { '<auto>', mode = 'nxso' },
        { 'm', mode = 'n' },
        { 's', mode = 'nv' },
      },
    },
  }
end

return M
