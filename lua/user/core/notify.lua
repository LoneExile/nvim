vim.notify = require('notify')
require('notify').setup({
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
  minimum_width = 50,
  render = 'default',
  stages = 'fade_in_slide_out',
  timeout = 1000,
  top_down = true,
})
