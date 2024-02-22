local M = {}

-- M.wh_key = {
--   wh_mappings = {
--     e = {
--       function()
--         -- vim.cmd('Oil --float')
--         vim.cmd('Oil')
--       end,
--       'Explorer',
--       mode = { 'n' },
--     },
--   },
-- }

M.setup = function(_, _)
  -- settings.utils.setup_mappings('<leader>', M.wh_key.wh_mappings, _)
  return {
    'stevearc/oil.nvim',
    cmd = { 'Oil' },
    config = function()
      local status_ok_code, oil = pcall(require, 'oil')
      if not status_ok_code then
        return
      end

      vim.keymap.set(
        'n',
        '-',
        -- require('oil').open
        function()
          vim.cmd('Oil')
        end,
        { desc = 'Oil' }
      )

      local config = {
        keymaps = {
          ['g?'] = 'actions.show_help',
          ['<CR>'] = 'actions.select',
          -- ['<C-v>'] = 'actions.select_vsplit',
          -- ['<C-s>'] = 'actions.select_split',
          ['<C-t>'] = 'actions.select_tab',
          ['<C-p>'] = 'actions.preview',
          ['<C-c>'] = 'actions.close',
          ['<C-l>'] = 'actions.refresh',
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
