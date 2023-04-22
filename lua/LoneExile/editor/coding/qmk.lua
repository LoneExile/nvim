local M = {}
M.enabled = false

M.setup = function()
  return {
    'codethread/qmk.nvim',
    enabled = M.enabled,
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
