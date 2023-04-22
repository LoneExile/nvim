local M = {}

M.setup = function()
  return {
    'nacro90/numb.nvim',
    event = 'BufRead',
    config = function()
      local status_ok_code, numb = pcall(require, 'numb')
      if not status_ok_code then
        return
      end

      local config = {
        show_numbers = true, -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
        number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
        centered_peeking = true, -- Peeked line will be centered relative to window
      }

      numb.setup(config)
    end,
  }
end

return M
