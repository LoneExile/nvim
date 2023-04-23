local M = {}

M.setup = function()
  return {
    's1n7ax/nvim-window-picker',
    config = function()
      local status_ok, windowPicker = pcall(require, 'window-picker')
      if not status_ok then
        vim.notify('windowPicker' .. ' not found!')
        return
      end
      windowPicker.setup({
        autoselect_one = true,
        include_current = false,
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { 'neo-tree', 'neo-tree-popup', 'notify', 'quickfix' },

            -- if the buffer type is one of following, the window will be ignored
            buftype = { 'terminal' },
          },
        },
        other_win_hl_color = '#e35e4f',
      })

      vim.keymap.set('n', '<leader>a', function()
        local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end, { desc = 'Pick a window' })
    end,
  }
end

return M
