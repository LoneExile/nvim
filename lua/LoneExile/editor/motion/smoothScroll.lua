local M = {}

M.setup = function()
  return {
    'declancm/cinnamon.nvim',
    event = 'BufRead',
    config = function()
      local status_ok, smoothScroll = pcall(require, 'cinnamon')
      if not status_ok then
        return
      end

      smoothScroll.setup({
        keymaps = {
          basic = true,
          extra = false,
        },
        options = {
          delay = 2,

          max_delta = {
            line = false,
            column = false,
            time = 1000,
          },

          step_size = {
            vertical = 1,
            horizontal = 2,
          },
        },
      })
    end,
  }
end

return M
