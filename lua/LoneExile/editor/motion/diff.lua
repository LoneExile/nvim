local M = {}

M.setup = function()
  return {
    'echasnovski/mini.diff',
    event = 'BufRead',
    config = function()
      local status_ok_code, diff = pcall(require, 'mini.diff')
      if not status_ok_code then
        return
      end
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  }
end

return M
