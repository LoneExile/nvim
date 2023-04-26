local M = {}

M.setup = function()
  return {
    'codethread/qmk.nvim',
    config = function()
      local status_ok, qmk = pcall(require, 'qmk')
      if not status_ok then
        return
      end
      local conf = {
        name = 'LAYOUT',
        layout = {
          '_ x x x x x _ x x x x x',
          '_ x x x x x _ x x x x x',
          '_ x x x x x _ x x x x x',
          '_ x x x x x _ x x x x x',
        },
      }
      qmk.setup(conf)
    end,
  }
end

return M
