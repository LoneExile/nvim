local M = {}

M.wh_key = {
  wh_mappings = {
    u = {
      name = '+Utility',
      o = {
        function()
          vim.cmd('Oil --float')
        end,
        'Oil',
        mode = { 'n' },
      },
    },
  },
}

vim.keymap.set(
  'n',
  '-',
  -- require('oil').open
  function()
    vim.cmd('Oil --float')
  end,
  { desc = 'Open parent directory' }
)

M.setup = function()
  return {
    'stevearc/oil.nvim',
    cmd = { 'Oil' },
    config = function()
      local status_ok_code, spectre = pcall(require, 'oil')
      if not status_ok_code then
        return
      end

      local config = {
        keymaps = {
          ['g?'] = 'actions.show_help',
          ['<CR>'] = 'actions.select',
          ['<C-s>'] = 'actions.select_vsplit',
          ['<C-h>'] = 'actions.select_split',
          ['<C-t>'] = 'actions.select_tab',
          ['<C-p>'] = 'actions.preview',
          ['<C-c>'] = 'actions.close',
          ['<C-l>'] = 'actions.refresh',
          ['-'] = 'actions.parent',
          ['_'] = 'actions.open_cwd',
          ['`'] = 'actions.cd',
          ['~'] = 'actions.tcd',
          ['g.'] = 'actions.toggle_hidden',
        },
        float = {
          -- Padding around the floating window
          padding = 2,
          max_width = 50,
          max_height = 40,
          border = 'rounded',
          win_options = {
            winblend = 10,
          },
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          override = function(conf)
            return conf
          end,
        },
      }

      spectre.setup(config)
    end,
  }
end

return M
