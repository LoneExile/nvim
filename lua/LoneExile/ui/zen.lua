local M = {}

M.wh_key = {
  wh_mappings = {
    u = {
      name = '+Utility',
      z = { '<cmd>ZenMode<cr>', 'Zen', mode = { 'n' } },
    },
  },
}

M.setup = function()
  return {
    'folke/zen-mode.nvim',
    lazy = true,
    cmd = 'ZenMode',
    config = function()
      local status_ok, zen_mode = pcall(require, 'zen-mode')
      if not status_ok then
        vim.notify('zen_mode' .. ' not found!')
        return
      end

      zen_mode.setup()
    end,
  }
end

return M
