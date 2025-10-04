local M = {}

M.keys = {
  {
    '<leader>dU',
    '',
    desc = 'UI',
    mode = 'n',
  },
  {
    '<leader>dUT',
    "<cmd>lua require('dapui').toggle()<cr>",
    desc = 'Toggle Dap UI',
    mode = 'n',
  },
  {
    '<leader>dUe',
    "<cmd>lua require('dapui').eval()<cr>",
    desc = 'Evaluate Expression',
    mode = 'n',
  },
  {
    '<leader>dUf',
    "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
    desc = 'UI Scopes',
    mode = 'n',
  },
}

M.setup = function(_, _)
  return {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap' },
    lazy = true,
    keys = M.keys,
    config = function()
      local status_ok_ui, dapui = pcall(require, 'dapui')
      if not status_ok_ui then
        -- vim.notify('dapui' .. ' not found!')
        print('dapui not found!')
        return
      end

      local config = {
        icons = { expanded = '▾', collapsed = '▸' },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
          toggle = 't',
        },
        -- Expand lines larger than the window
        -- Requires >= 0.7
        expand_lines = vim.fn.has('nvim-0.7'),
        -- Layouts define sections of the screen to place windows.
        -- The position can be "left", "right", "top" or "bottom".
        -- The size specifies the height/width depending on position. It can be an Int
        -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
        -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
        -- Elements are the elements shown in the layout (in order).
        -- Layouts are opened in order so that earlier layouts take priority in window sizing.
        layouts = {
          {
            elements = {
              -- Elements can be strings or table with id and size keys.
              { id = 'scopes', size = 0.25 },
              'breakpoints',
              'stacks',
              'watches',
            },
            size = 40, -- 40 columns
            position = 'right',
          },
          {
            elements = {
              'repl',
              'console',
            },
            size = 0.25, -- 25% of total lines
            position = 'bottom',
          },
        },
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil, -- Floats will be treated as percentage of your screen.
          border = 'single', -- Border style. Can be "single", "double" or "rounded"
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Can be integer or nil.
        },
      }

      dapui.setup(config)

      ------------------------------------------------------------------------------
      local status_ok, dap = pcall(require, 'dap')
      if not status_ok then
        return
      end
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close({})
      end
    end,
  }
end

return M
