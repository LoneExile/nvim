local M = {}

M.keys = {
  {
    '<leader>uo',
    function()
      vim.cmd('Oil --float')
    end,
    desc = 'Oil',
    mode = 'n',
  },
}

M.setup = function(_, _)
  vim.keymap.set(
    'n',
    '-',
    -- require('oil').open
    function()
      vim.cmd('Oil')
    end,
    { desc = 'Oil' }
  )
  return {
    'stevearc/oil.nvim',
    cmd = { 'Oil' },
    config = function()
      local status_ok_code, oil = pcall(require, 'oil')
      if not status_ok_code then
        return
      end

      local config = {
        keymaps = {
          ['g?'] = 'actions.show_help',
          ['<CR>'] = 'actions.select',
          -- ['<C-h>'] = 'actions.select_split',
          ['<C-h>'] = false,
          ['<C-s>'] = 'actions.select_vsplit',
          ['<C-t>'] = 'actions.select_tab',
          ['<C-p>'] = 'actions.preview',
          ['<C-c>'] = 'actions.close',
          ['<C-l>'] = false,
          ['<C-r>'] = 'actions.refresh',
          ['-'] = 'actions.parent',
          ['_'] = 'actions.open_cwd',
          ['`'] = 'actions.cd',
          ['~'] = 'actions.tcd',
          ['gs'] = 'actions.change_sort',
          ['gx'] = 'actions.open_external',
          ['g.'] = 'actions.toggle_hidden',
          ['g\\'] = 'actions.toggle_trash',
        },
        float = {
          -- Padding around the floating window
          padding = 2,
          max_width = 80,
          max_height = 45,
          border = 'rounded',
          win_options = {
            winblend = 0,
          },
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          override = function(conf)
            return conf
          end,
        },
        view_options = {
          show_hidden = true,
        },
        -- Configuration for the floating progress window
        progress = {
          win_options = {
            winblend = 0,
          },
        },
      }

      oil.setup(config)
    end,
  }
end

return M
