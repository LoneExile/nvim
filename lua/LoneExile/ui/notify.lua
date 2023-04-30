local M = {}

M.wh_key = {
  wh_mappings = {
    ['s'] = {
      name = 'Search',
      n = {
        "<cmd>lua require('telescope').extensions.notify.notify(require('telescope.themes').get_dropdown({initial_mode = 'normal'}))<cr>",
        'Notifications',
        mode = { 'n' },
      },
    },
  },
}
M.setup = function(s, _)
  return {
    'rcarriga/nvim-notify',
    config = function()
      local status_ok, notify = pcall(require, 'notify')
      if not status_ok then
        return
      end
      local background = 'Normal'
      if s.tranparent then
        background = '#000000'
      end

      notify.setup({
        background_colour = background,
        fps = 30,
        icons = {
          DEBUG = '',
          ERROR = '',
          INFO = '',
          TRACE = '✎',
          WARN = '',
        },
        level = 2,
        minimum_width = 30,
        render = 'default',
        stages = 'fade_in_slide_out',
        timeout = 500,
        top_down = true,
      })
      vim.notify = require('notify')
    end,
  }
end

return M
