local M = {}

M.setup = function()
  return {
    'echasnovski/mini.nvim',
    event = 'BufRead',
    config = function()
      local status_ok_code, mini = pcall(require, 'mini.surround')
      if not status_ok_code then
        return
      end

      mini.setup({
        -- Add custom surroundings to be used on top of builtin ones. For more
        -- information with examples, see `q:h MiniSurround.config`.
        custom_surroundings = nil,

        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 1000,

        -- Module mappings. Use `''` (empty string) to disable one.
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

        -- Number of lines within which surrounding is searched
        n_lines = 20,

        -- How to search for surrounding (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
        -- see `q:h MiniSurround.config`.
        search_method = 'cover',
      })
    end,
  }
end

return M
