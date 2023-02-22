local M = {}

M.enabled = true

M.setup = function()
  return {
    'anuvyklack/windows.nvim',
    enabled = M.enabled,
    event = 'WinEnter',
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false

      local status, windows = pcall(require, 'windows')
      if not status then
        return
      end

      windows.setup({
        autowidth = {
          enable = true,
          winwidth = 5,
          filetype = {
            help = 2,
          },
        },
        ignore = {
          buftype = { 'quickfix' },
          filetype = { 'neo-tree', 'lspsagaoutline', 'spectre_panel', 'DiffviewFiles' },
        },
        animation = {
          enable = true,
          duration = 300,
          fps = 30,
          easing = 'in_out_sine',
        },
      })
    end,
  }
end

return M
