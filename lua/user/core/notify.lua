local status_ok, notify = pcall(require, 'notify')
if not status_ok then
  return
end
notify.setup({
  background_colour = '#000000',
  -- background_colour = 'Normal',
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
