local M = {}

M.setup = function()
  return {
    'nvim-mini/mini.diff',
    event = 'BufRead',
    config = function()
      local status_ok_code, diff = pcall(require, 'mini.diff')
      if not status_ok_code then
        return
      end
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
        mappings = {
          -- Apply hunks inside a visual/operator region
          -- apply = 'gh',
          apply = '',

          -- Reset hunks inside a visual/operator region
          reset = 'gH',

          -- Hunk range textobject to be used inside operator
          -- Works also in Visual mode if mapping differs from apply and reset
          -- textobject = 'gh',
          textobject = '',

          -- Go to hunk range in corresponding direction
          goto_first = '[H',
          goto_prev = '[h',
          goto_next = ']h',
          goto_last = ']H',
        },
      })
    end,
  }
end

return M
