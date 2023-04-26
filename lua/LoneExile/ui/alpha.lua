local M = {}

M.wh_key = {
  wh_mappings = {
    [';'] = {
      '<cmd>Alpha<CR>',
      'Dashboard',
      mode = { 'n' },
    },
  },
}

M.setup = function(settings, _)
  return {
    'goolord/alpha-nvim',
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

      -- dashboard.section.header.val = {
      --   [[　　　 　　/＾>》, -―‐‐＜＾}]],
      --   [[　　　 　./:::/,≠´::::::ヽ.]],
      --   [[　　　　/::::〃::::／}::丿ハ]],
      --   [[　　　./:::::i{l|／　ﾉ／ }::}]],
      --   [[　　 /:::::::瓜イ＞　´＜ ,:ﾉ]],
      --   [[　 ./::::::|ﾉﾍ.{､　(_ﾌ_ノﾉイ＿]],
      --   [[　 |:::::::|／}｀ｽ /          /]],
      --   [[.　|::::::|(_:::つ/ ThinkPad /　neovim!]],
      --   [[.￣￣￣￣￣￣￣＼/＿＿＿＿＿/￣￣￣￣￣]],
      -- }
      dashboard.section.header.val = {
        [[]],
        [[]],
        [[]],
        [[]],
        [[]],
        [[  ／|_       ]],
        [[ (o o /      ]],
        [[  |.   ~.    ]],
        [[  じしf_,)ノ ]],
      }
      -- dashboard.section.header.val = {
      --   '',
      --   '⡆⣐⢕⢕⢕⢕⢕⢕⢕⢕⠅⢗⢕⢕⢕⢕⢕⢕⢕⠕⠕⢕⢕⢕⢕⢕⢕⢕⢕⢕',
      --   '⢐⢕⢕⢕⢕⢕⣕⢕⢕⠕⠁⢕⢕⢕⢕⢕⢕⢕⢕⠅⡄⢕⢕⢕⢕⢕⢕⢕⢕⢕',
      --   '⢕⢕⢕⢕⢕⠅⢗⢕⠕⣠⠄⣗⢕⢕⠕⢕⢕⢕⠕⢠⣿⠐⢕⢕⢕⠑⢕⢕⠵⢕',
      --   '⢕⢕⢕⢕⠁⢜⠕⢁⣴⣿⡇⢓⢕⢵⢐⢕⢕⠕⢁⣾⢿⣧⠑⢕⢕⠄⢑⢕⠅⢕',
      --   '⢕⢕⠵⢁⠔⢁⣤⣤⣶⣶⣶⡐⣕⢽⠐⢕⠕⣡⣾⣶⣶⣶⣤⡁⢓⢕⠄⢑⢅⢑',
      --   '⠍⣧⠄⣶⣾⣿⣿⣿⣿⣿⣿⣷⣔⢕⢄⢡⣾⣿⣿⣿⣿⣿⣿⣿⣦⡑⢕⢤⠱⢐',
      --   '⢠⢕⠅⣾⣿⠋⢿⣿⣿⣿⠉⣿⣿⣷⣦⣶⣽⣿⣿⠈⣿⣿⣿⣿⠏⢹⣷⣷⡅⢐',
      --   '⣔⢕⢥⢻⣿⡀⠈⠛⠛⠁⢠⣿⣿⣿⣿⣿⣿⣿⣿⡀⠈⠛⠛⠁⠄⣼⣿⣿⡇⢔',
      --   '⢕⢕⢽⢸⢟⢟⢖⢖⢤⣶⡟⢻⣿⡿⠻⣿⣿⡟⢀⣿⣦⢤⢤⢔⢞⢿⢿⣿⠁⢕',
      --   '⢕⢕⠅⣐⢕⢕⢕⢕⢕⣿⣿⡄⠛⢀⣦⠈⠛⢁⣼⣿⢗⢕⢕⢕⢕⢕⢕⡏⣘⢕',
      --   '⢕⢕⠅⢓⣕⣕⣕⣕⣵⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣷⣕⢕⢕⢕⢕⡵⢀⢕⢕',
      --   '⢑⢕⠃⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⢕⢕⢕',
      --   '⣆⢕⠄⢱⣄⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢁⢕⢕⠕⢁',
      --   '⣿⣦⡀⣿⣿⣷⣶⣬⣍⣛⣛⣛⡛⠿⠿⠿⠛⠛⢛⣛⣉⣭⣤⣂⢜⠕⢑⣡⣴⣿',
      --   '',
      -- }
      dashboard.section.buttons.val = {
        dashboard.button('f', '  Find file', ':Telescope find_files <CR>'),
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('p', '  Find project', ':Telescope projects <CR>'),
        dashboard.button('r', '  Recently used files', ':Telescope oldfiles <CR>'),
        -- TODO: add PATH for windows
        dashboard.button('c', '  Configuration', ':e ~/.config/nvim/init.lua <CR>'),
        dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
      }

      local function info()
        local plugins = require('lazy').stats().count
        local v = vim.version()
        local datetime = os.date(' %d-%m-%Y   %H:%M:%S')
        local platform = vim.fn.has('win32') == 1 and '' or ''
        return string.format(' %d   v%d.%d.%d %s  %s', plugins, v.major, v.minor, v.patch, platform, datetime)
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
      vim.cmd([[lua vim.o.ls=0]]) -- disable statusline
      alpha.setup(dashboard.opts)

      -------------------------------------------------------------------------------
      local group = vim.api.nvim_create_augroup('autocmd_alpha', { clear = true })

      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = {
          'alpha',
        },
        callback = function()
          vim.cmd([[lua vim.o.ls=0]]) -- disable statusline
        end,
      })
    end,
  }
end

return M
