local M = {}

M.wh_key = {
  wh_mappings = {
    ['e'] = {
      '<cmd>Neotree action=focus source=filesystem position=right toggle=true<CR>',
      -- function()
      -- 	vim.cmd("Neotree position=right toggle=true")
      -- end,
      'Explorer',
      mode = { 'n' },
    },
    ['b'] = {
      '<cmd>Neotree action=focus source=buffers position=right toggle=true<CR>',
      'Buffer',
      mode = { 'n' },
    },
    g = {
      ['n'] = {
        '<cmd>Neotree action=focus source=git_status position=right toggle=true<CR>',
        'Neogit',
        mode = { 'n' },
      },
    },
    u = {
      name = '+Utility',
      n = {
        name = '+Neotree',
        b = {
          '<cmd>Neotree action=focus source=buffers position=right toggle=true<CR>',
          'Buffer',
          mode = { 'n' },
        },
        g = {
          '<cmd>Neotree action=focus source=git_status position=right toggle=true<CR>',
          'Git',
          mode = { 'n' },
        },
        r = {
          '<cmd>Neotree action=focus source=filesystem position=right toggle=true<CR>',
          'Files',
          mode = { 'n' },
        },
      },
    },
  },
}

M.setup = function(_, _)
  return {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = { 'Neotree' },
    keys = { '<leader>' },
    -- event = 'BufRead',
    -- branch = 'v2.x',
    branch = 'main',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
      { 's1n7ax/nvim-window-picker' },
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      -- vim.schedule(function()
      local status_ok, neoTree = pcall(require, 'neo-tree')
      if not status_ok then
        return
      end

      neoTree.setup({
        event_handlers = {
          {
            event = 'file_opened',
            handler = function(_)
              vim.cmd('Neotree close')
            end,
          },
        },
        use_default_mappings = false,
        source_selector = {
          winbar = true, -- toggle to show selector on winbar
          statusline = false, -- toggle to show selector on statusline
          sources = {
            { source = 'filesystem' },
            { source = 'buffers' },
            { source = 'git_status' },
            -- { source = 'document_symbols' },
          },
          highlight_tab_active = 'NeoTreeTabActivemod',
        },
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        enable_normal_mode_for_inputs = true,
        sort_function = nil, -- use a custom function for sorting files and directories in the tree
        -- sort_function = function (a,b)
        --       if a.type == b.type then
        --           return a.path > b.path
        --       else
        --           return a.type > b.type
        --       end
        --   end , -- this sorts files and directories descendantly
        default_component_configs = {
          container = {
            enable_character_fade = true,
          },
          indent = {
            indent_size = 1,
            padding = 0, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = '│',
            last_indent_marker = '└',
            highlight = 'NeoTreeIndentMarker',
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = '',
            expander_expanded = '',
            expander_highlight = 'NeoTreeExpander',
          },
          icon = {
            folder_closed = '',
            folder_open = '',
            folder_empty = '',
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = '*',
            highlight = 'NeoTreeFileIcon',
          },
          modified = {
            symbol = '[+]',
            highlight = 'NeoTreeModified',
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = 'NeoTreeFileName',
          },
        },
        window = {
          position = 'right',
          width = 25,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            -- ["<space>"] = {
            -- 	"toggle_node",
            -- 	nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            -- },
            ['<2-LeftMouse>'] = 'open',
            ['<cr>'] = 'open',
            -- ['<esc>'] = 'revert_preview',
            ['P'] = { 'toggle_preview', config = { use_float = true } },
            ['S'] = 'open_split',
            ['s'] = 'open_vsplit',
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ['t'] = 'open_tabnew',
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ['w'] = 'open_with_window_picker',
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ['C'] = 'close_node',
            ['z'] = 'close_all_nodes',
            --["Z"] = "expand_all_nodes",
            ['a'] = {
              'add',
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = 'none', -- "none", "relative", "absolute"
              },
            },
            ['A'] = 'add_directory', -- also accepts the optional config.show_path option like "add".
            ['d'] = 'delete',
            ['r'] = 'rename',
            ['y'] = 'copy_to_clipboard',
            ['x'] = 'cut_to_clipboard',
            ['p'] = 'paste_from_clipboard',
            ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ['q'] = 'close_window',
            ['R'] = 'refresh',
            ['?'] = 'show_help',
            ['<'] = 'prev_source',
            ['>'] = 'next_source',
          },
        },
        nesting_rules = {},
        -- harpoon_index = function(config, node, state)
        filesystem = {
          components = {
            harpoon_index = function(config, node)
              local harpoon, Marked = pcall(require, 'harpoon.mark')
              if not harpoon then
                return {}
              end
              -- local Marked = require('harpoon.mark')
              local path = node:get_id()
              local succuss, index = pcall(Marked.get_index_of, path)
              if succuss and index and index > 0 then
                return {
                  text = string.format(' ⥤ %d', index), -- <-- Add your favorite harpoon like arrow here
                  highlight = config.highlight or 'NeoTreeDirectoryIcon',
                }
              else
                return {}
              end
            end,
          },
          renderers = {
            file = {
              { 'indent' },
              { 'icon' },
              {
                'container',
                content = {
                  {
                    'name',
                    zindex = 10,
                  },
                  { 'harpoon_index', zindex = 10 },
                  -- {
                  --   "symlink_target",
                  --   zindex = 10,
                  --   highlight = "NeoTreeSymbolicLinkTarget",
                  -- },
                  { 'clipboard', zindex = 10 },
                  { 'bufnr', zindex = 10 },
                  { 'modified', zindex = 20, align = 'right' },
                  { 'diagnostics', zindex = 20, align = 'right' },
                  { 'git_status', zindex = 20, align = 'right' },
                },
              },
            },
          },
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              --".DS_Store",
              --"thumbs.db"
            },
          },
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },

          -- time the current file is changed while the tree is open.
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
          -- in whatever position is specified in window.position
          -- "open_current",  -- netrw disabled, opening a directory opens within the
          -- window like netrw would, regardless of window.position
          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              ['<bs>'] = 'navigate_up',
              ['.'] = 'set_root',
              ['H'] = 'toggle_hidden',
              ['/'] = 'fuzzy_finder',
              ['D'] = 'fuzzy_finder_directory',
              ['f'] = 'filter_on_submit',
              ['<c-x>'] = 'clear_filter',
              ['[g'] = 'prev_git_modified',
              [']g'] = 'next_git_modified',
            },
          },
        },
        buffers = {
          follow_current_file = { enable = true }, -- This will find and focus the file in the active buffer every
          -- time the current file is changed while the tree is open.
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ['bd'] = 'buffer_delete',
              ['<bs>'] = 'navigate_up',
              ['.'] = 'set_root',
            },
          },
        },
        git_status = {
          window = {
            position = 'float',
            mappings = {
              ['A'] = 'git_add_all',
              ['gu'] = 'git_unstage_file',
              ['ga'] = 'git_add_file',
              ['gr'] = 'git_revert_file',
              ['gc'] = 'git_commit',
              ['gp'] = 'git_push',
              ['gg'] = 'git_commit_and_push',
            },
          },
        },
      })
      -- end)
    end,
  }
end

return M
