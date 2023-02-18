local M = {}

M.setup = function(settings)
  return {
    'rcarriga/nvim-notify',
    config = function()
      local status_ok, notify = pcall(require, 'notify')
      if not status_ok then
        return
      end
      local background = 'Normal'
      if settings.tranparent then
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
        timeout = 1000,
        top_down = true,
      })
      vim.notify = require('notify')
    end,
  }
end

return M
