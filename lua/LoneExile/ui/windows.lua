local M = {}

M.wh_key = {
  wh_mappings = {
    m = { '<cmd>WindowsMaximize!<cr>', 'Maximize', mode = { 'n' } },
    u = {
      w = {
        name = '+Windows',
        m = { '<cmd>WindowsMaximize!<cr>', 'Maximize', mode = { 'n' } },
        e = { '<cmd>WindowsEqualize<cr>', 'Equal', mode = { 'n' } },
        t = { '<cmd>WindowsToggleAutowidth<cr>', 'Toggle', mode = { 'n' } },
      },
    },
  },
}

M.setup = function()
  return {
    'anuvyklack/windows.nvim',
    event = 'BufRead',
    cmd = { 'WindowsMaximize', 'WindowsEqualize', 'WindowsToggleAutowidth', 'Neotree' },
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
          filetype = {
            'neo-tree',
            'lspsagaoutline',
            'spectre_panel',
            'DiffviewFiles',
            'dap-repl',
            'dapui_console',
            'dapui_watches',
            'dapui_stacks',
            'dapui_breakpoints',
            'dapui_scopes',
          },
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
