local M = {}

-- M.keys = {
--   {
--     '<leader>;',
--     '<cmd>Alpha<CR>',
--     desc = 'Dashboard',
--     mode = 'n',
--   },
-- }

M.setup = function(settings, _)
  return {
    'goolord/alpha-nvim',
    -- keys = M.keys,
    config = function()
      local status_ok, alpha = pcall(require, 'alpha')
      if not status_ok then
        return
      end

      local dashboard = require('alpha.themes.dashboard')
      -- padding
      dashboard.section.header.opts.position = 'center'
      dashboard.section.buttons.opts.position = 'center'
      dashboard.section.footer.opts.position = 'center'
      dashboard.section.header.val = {
        '',
        '⡆⣐⢕⢕⢕⢕⢕⢕⢕⢕⠅⢗⢕⢕⢕⢕⢕⢕⢕⠕⠕⢕⢕⢕⢕⢕⢕⢕⢕⢕',
        '⢐⢕⢕⢕⢕⢕⣕⢕⢕⠕⠁⢕⢕⢕⢕⢕⢕⢕⢕⠅⡄⢕⢕⢕⢕⢕⢕⢕⢕⢕',
        '⢕⢕⢕⢕⢕⠅⢗⢕⠕⣠⠄⣗⢕⢕⠕⢕⢕⢕⠕⢠⣿⠐⢕⢕⢕⠑⢕⢕⠵⢕',
        '⢕⢕⢕⢕⠁⢜⠕⢁⣴⣿⡇⢓⢕⢵⢐⢕⢕⠕⢁⣾⢿⣧⠑⢕⢕⠄⢑⢕⠅⢕',
        '⢕⢕⠵⢁⠔⢁⣤⣤⣶⣶⣶⡐⣕⢽⠐⢕⠕⣡⣾⣶⣶⣶⣤⡁⢓⢕⠄⢑⢅⢑',
        '⠍⣧⠄⣶⣾⣿⣿⣿⣿⣿⣿⣷⣔⢕⢄⢡⣾⣿⣿⣿⣿⣿⣿⣿⣦⡑⢕⢤⠱⢐',
        '⢠⢕⠅⣾⣿⠋⢿⣿⣿⣿⠉⣿⣿⣷⣦⣶⣽⣿⣿⠈⣿⣿⣿⣿⠏⢹⣷⣷⡅⢐',
        '⣔⢕⢥⢻⣿⡀⠈⠛⠛⠁⢠⣿⣿⣿⣿⣿⣿⣿⣿⡀⠈⠛⠛⠁⠄⣼⣿⣿⡇⢔',
        '⢕⢕⢽⢸⢟⢟⢖⢖⢤⣶⡟⢻⣿⡿⠻⣿⣿⡟⢀⣿⣦⢤⢤⢔⢞⢿⢿⣿⠁⢕',
        '⢕⢕⠅⣐⢕⢕⢕⢕⢕⣿⣿⡄⠛⢀⣦⠈⠛⢁⣼⣿⢗⢕⢕⢕⢕⢕⢕⡏⣘⢕',
        '⢕⢕⠅⢓⣕⣕⣕⣕⣵⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣷⣕⢕⢕⢕⢕⡵⢀⢕⢕',
        '⢑⢕⠃⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⢕⢕⢕',
        '⣆⢕⠄⢱⣄⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢁⢕⢕⠕⢁',
        '⣿⣦⡀⣿⣿⣷⣶⣬⣍⣛⣛⣛⡛⠿⠿⠿⠛⠛⢛⣛⣉⣭⣤⣂⢜⠕⢑⣡⣴⣿',
        '',
      }
      dashboard.section.buttons.val = {
        dashboard.button('f', '󰱼  Find file', '<cmd>FzfLua files<cr>'),
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        -- dashboard.button('p', '  Find project', ':lua require("telescope").extensions.projects.projects{}<CR>'),
        dashboard.button('r', '󰄉  Recently used files', '<cmd>FzfLua oldfiles<cr>'),
        dashboard.button('c', '  Configuration', ':e ' .. settings.conf_loc .. settings.separator .. 'init.lua <CR>'),
        dashboard.button('q', '󰩈  Quit Neovim', ':qa<CR>'),
      }

      local function info()
        local plugins = require('lazy').stats().count
        local v = vim.version()
        local datetime = os.date(' %d-%m-%Y   %H:%M:%S')
        local platform = vim.fn.has('win32') == 1 and '' or ''
        return string.format(' %d   v%d.%d.%d %s  %s', plugins, v.major, v.minor, v.patch, platform, datetime)
      end

      dashboard.section.footer.val = {
        '',
        '                 ' .. settings.root,
        '',
        info(),
      }

      dashboard.section.footer.opts.hl = 'Type'
      dashboard.section.header.opts.hl = 'Include'
      dashboard.section.buttons.opts.hl = 'Keyword'

      dashboard.opts.opts.noautocmd = true
      -- vim.cmd([[lua vim.o.ls=0]]) -- disable statusline
      alpha.setup(dashboard.opts)

      -------------------------------------------------------------------------------
      -- local group = vim.api.nvim_create_augroup('autocmd_alpha', { clear = true })

      -- vim.api.nvim_create_autocmd('FileType', {
      --   group = group,
      --   pattern = {
      --     'alpha',
      --   },
      --   callback = function()
      --     vim.cmd([[lua vim.o.ls=0]]) -- disable statusline
      --   end,
      -- })
    end,
  }
end

return M
