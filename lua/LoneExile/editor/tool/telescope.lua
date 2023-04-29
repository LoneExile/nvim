local M = {}

M.wh_key = {
  wh_mappings = {
    ['s'] = {
      name = 'Search',
      b = {
        '<cmd>Telescope buffers<cr>',
        'find',
        mode = { 'n' },
      },
      g = {
        '<cmd>Telescope git_status<cr>',
        'Open changed file',
        mode = { 'n' },
      },
      c = {
        '<cmd>Telescope colorscheme<cr>',
        'Colorscheme',
        mode = { 'n' },
      },
      f = {
        '<cmd>Telescope find_files<cr>',
        'Find File',
        mode = { 'n' },
      },
      h = {
        '<cmd>Telescope help_tags<cr>',
        'Find Help',
        mode = { 'n' },
      },
      H = {
        '<cmd>Telescope highlights<cr>',
        'Find highlight groups',
        mode = { 'n' },
      },
      M = {
        '<cmd>Telescope man_pages<cr>',
        'Man Pages',
        mode = { 'n' },
      },
      o = {
        '<cmd>Telescope oldfiles<cr>',
        'Open Recent File',
        mode = { 'n' },
      },
      r = {
        '<cmd>Telescope resume<cr>',
        'Resume',
        mode = { 'n' },
      },
      R = {
        '<cmd>Telescope registers<cr>',
        'Registers',
        mode = { 'n' },
      },
      t = {
        '<cmd>Telescope live_grep<cr>',
        'Text',
        mode = { 'n' },
      },
      T = {
        "<cmd>lua require('telescope.builtin').grep_string()<cr>",
        'Text (string)',
        mode = { 'n' },
      },
      k = {
        '<cmd>Telescope keymaps<cr>',
        'Keymaps',
        mode = { 'n' },
      },
      C = {
        '<cmd>Telescope commands<cr>',
        'Commands',
        mode = { 'n' },
      },
      p = {
        "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
        'Colorscheme with Preview',
        mode = { 'n' },
      },
      u = {
        "<cmd>lua require('telescope').extensions.undo.undo()<cr>",
        'Undo',
        mode = { 'n' },
      },
    },
    ['g'] = {
      f = {
        '<cmd>Telescope git_status<cr>',
        'Open changed file',
        mode = { 'n' },
      },
      b = {
        '<cmd>Telescope git_branches<cr>',
        'Checkout branch',
        mode = { 'n' },
      },
      c = {
        '<cmd>Telescope git_commits<cr>',
        'Checkout commit',
        mode = { 'n' },
      },
      C = {
        '<cmd>Telescope git_bcommits<cr>',
        'Checkout commit(for current file)',
        mode = { 'n' },
      },
    },
  },
}

M.setup = function()
  return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      --  "nvim-telescope/telescope-ui-select.nvim"
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
    },
    config = function()
      local status, telescope = pcall(require, 'telescope')
      if not status then
        return
      end

      local _, actions = pcall(require, 'telescope.actions')
      local _, sorters = pcall(require, 'telescope.sorters')
      local _, previewers = pcall(require, 'telescope.previewers')
      local configsTelescope = {
        defaults = {
          file_previewer = previewers.vim_buffer_cat.new,
          grep_previewer = previewers.vim_buffer_vimgrep.new,
          qflist_previewer = previewers.vim_buffer_qflist.new,
          file_sorter = sorters.get_fuzzy_file,
          generic_sorter = sorters.get_generic_fuzzy_sorter,
          prompt_prefix = ' ',
          selection_caret = ' ',
          entry_prefix = '  ',
          initial_mode = 'insert',
          selection_strategy = 'reset',
          sorting_strategy = 'descending',
          layout_strategy = 'horizontal',
          layout_config = {
            width = 0.75,
            preview_cutoff = 120,
            horizontal = {
              preview_width = function(_, cols, _)
                if cols < 120 then
                  return math.floor(cols * 0.5)
                end
                return math.floor(cols * 0.6)
              end,
              mirror = false,
            },
            vertical = { mirror = false },
          },
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--glob=!.git/',
          },
          mappings = {
            i = {
              ['<C-n>'] = actions.move_selection_next,
              ['<C-p>'] = actions.move_selection_previous,
              ['<C-c>'] = actions.close,
              ['<C-j>'] = actions.cycle_history_next,
              ['<C-k>'] = actions.cycle_history_prev,
              ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
              ['<CR>'] = actions.select_default,
            },
            n = {
              ['<C-n>'] = actions.move_selection_next,
              ['<C-p>'] = actions.move_selection_previous,
              ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
              ['dd'] = actions.delete_buffer,
            },
          },
          file_ignore_patterns = {},
          path_display = { 'smart' },
          winblend = 0,
          border = {},
          borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
          color_devicons = true,
          set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        },
        pickers = {
          find_files = {
            theme = 'dropdown',
            hidden = true,
            previewer = false,
          },
          colorscheme = {
            theme = 'dropdown',
          },
          live_grep = {
            --@usage don't include the filename in the search results
            only_sort_text = true,
            theme = 'dropdown',
          },
          grep_string = {
            only_sort_text = true,
            theme = 'dropdown',
          },
          buffers = {
            theme = 'dropdown',
            previewer = false,
            initial_mode = 'normal',
          },
          planets = {
            show_pluto = true,
            show_moon = true,
          },
          git_status = {
            initial_mode = 'normal',
          },
          git_files = {
            theme = 'dropdown',
            hidden = true,
            previewer = false,
            show_untracked = true,
            initial_mode = 'normal',
          },
          lsp_references = {
            theme = 'dropdown',
            initial_mode = 'normal',
          },
          lsp_definitions = {
            theme = 'dropdown',
            initial_mode = 'normal',
          },
          lsp_declarations = {
            theme = 'dropdown',
            initial_mode = 'normal',
          },
          lsp_implementations = {
            theme = 'cursor',
            initial_mode = 'normal',
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          },
          -- ["ui-select"] = {
          -- 	require("telescope.themes").get_cursor({}),
          -- },
          undo = {
            mappings = {
              i = {
                ['<cr>'] = require('telescope-undo.actions').yank_additions,
                ['<S-cr>'] = require('telescope-undo.actions').yank_deletions,
                ['<C-cr>'] = require('telescope-undo.actions').restore,
              },
            },
          },
        },
      }

      if status then
        telescope.setup(configsTelescope)
        telescope.load_extension('fzf')
        telescope.load_extension('undo')
        -- telescope.load_extension("ui-select")
      end
    end,
  }
end

return M
