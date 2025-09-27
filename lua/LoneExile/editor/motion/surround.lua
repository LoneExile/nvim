local M = {}

M.setup = function()
  return {
    'nvim-mini/mini.surround',
    event = 'BufRead',
    config = function()
      local status_ok_code, mini = pcall(require, 'mini.surround')
      if not status_ok_code then
        return
      end

      -- https://github.com/folke/which-key.nvim/issues/837
      vim.o.timeout = false

      mini.setup({
        custom_surroundings = nil,
        highlight_duration = 1000,
        mappings = {
          add = 'sa', -- Add surrounding in Normal and Visual modes
          delete = 'sd', -- Delete surrounding
          find = 'sf', -- Find surrounding (to the right)
          find_left = 'sF', -- Find surrounding (to the left)
          highlight = 'sh', -- Highlight surrounding
          replace = 'sr', -- Replace surrounding
          update_n_lines = 'sn', -- Update `n_lines`
          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        },

        n_lines = 20,
        search_method = 'cover',
      })
    end,
  }
end

return M
