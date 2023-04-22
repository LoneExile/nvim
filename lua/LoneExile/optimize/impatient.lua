local M = {}

M.setup = function()
  return {
    'lewis6991/impatient.nvim',
    config = function()
      local status_ok, impatient = pcall(require, 'impatient')
      if not status_ok then
        return
      end

      impatient.enable_profile()
    end,
  }
end

return M
