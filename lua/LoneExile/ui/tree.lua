local M = {}

-- M.wh_key = {
--   wh_mappings = {
--   },
-- }

M.setup = function()
  return {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup({
        diagnostics = {
          enable = true,
          show_on_dirs = false,
          -- icons = {
          --   hint = ' ',
          --   info = ' ',
          --   warning = ' ',
          --   error = ' ',
          -- },
          icons = {
            hint = ' ',
            info = '⚑ ',
            warning = '▲ ',
            error = '✘ ',
          },
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
          ignore_list = {},
        },
        system_open = {
          cmd = nil,
          args = {},
        },
        git = {
          enable = true,
          ignore = false,
          timeout = 200,
        },
        renderer = {
          root_folder_label = false,
          indent_markers = {
            enable = false,
            icons = {
              corner = '└',
              edge = '│',
              item = '│',
              none = ' ',
            },
          },
          icons = {
            git_placement = 'after',
            modified_placement = 'after',
            webdev_colors = true,
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = false,
            },
            glyphs = {
              default = '',
              symlink = '',
              git = {
                unstaged = '',
                staged = 'S',
                unmerged = '',
                renamed = '➜',
                deleted = '',
                untracked = 'U',
                ignored = '◌',
              },
              folder = {
                default = '',
                open = '',
                empty = '',
                empty_open = '',
                symlink = '',
              },
            },
          },
          highlight_git = true,
          root_folder_modifier = ':t',
        },
        filters = {
          dotfiles = false,
          custom = { 'node_modules', '\\.cache' },
          exclude = {},
        },
        trash = {
          cmd = 'trash',
          require_confirm = true,
        },

        view = {
          centralize_selection = true,
          adaptive_size = false,
          side = 'right',
          preserve_window_proportions = true,
          float = {
            enable = true,
            quit_on_focus_loss = false,
            open_win_config = function()
              return {
                row = 1,
                width = 30,
                border = 'rounded',
                relative = 'editor',
                col = vim.o.columns,
                -- height = vim.o.lines,
                height = 40,
              }
            end,
          },
        },
      })
    end,
  }
end

return M
