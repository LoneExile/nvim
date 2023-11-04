local M = {}

M.wh_key = {
  wh_mappings = {
    ['s'] = {
      -- s = {
      s = {
        '<cmd>MurenToggle<CR>',
        'Muren',
        mode = { 'n' },
      },
      -- u = {
      --   '<cmd>MurenUnique<CR>',
      --   'Muren Unique',
      --   mode = { 'n' },
      -- },
      -- },
    },
  },
}

M.setup = function()
  return {
    'AckslD/muren.nvim',
    cmd = { 'MurenToggle', 'MurenUnique' },
    config = function()
      local status, muren = pcall(require, 'muren')
      if not status then
        return
      end

      local config = {
        -- general
        create_commands = true,
        -- default togglable options
        recursive = false,
        all_on_line = true,
        preview = true,
        -- keymaps
        keys = {
          close = 'q',
          toggle_side = '<Tab>',
          toggle_options_focus = '<C-s>',
          toggle_option_under_cursor = '<CR>',
          do_replace = '<CR>',
        },
        -- ui sizes
        patterns_width = 30,
        patterns_height = 10,
        options_width = 15,
        preview_height = 12,
        -- options order in ui
        order = {
          'buffer',
          'recursive',
          'all_on_line',
          'preview',
        },
        -- highlights used for options ui
        hl = {
          options = {
            on = '@string',
            off = '@variable.builtin',
          },
        },
      }

      muren.setup(config)
    end,
  }
end

return M
