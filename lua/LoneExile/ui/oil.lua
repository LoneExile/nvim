local M = {}

M.setup = function()
  return {
    'stevearc/oil.nvim',
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
      }

      spectre.setup(config)
    end,
  }
end

return M
