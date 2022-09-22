M = {}

local status_ok, worktree = pcall(require, 'git-worktree')
if status_ok then
  worktree.setup()
end

local status, telescope = pcall(require, 'telescope')
if not status then
  return
end

function M.setup()
  local previewers = require('telescope.previewers')
  local sorters = require('telescope.sorters')
  local actions = require('telescope.actions')

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
      git_files = {
        theme = 'dropdown',
        hidden = true,
        previewer = false,
        show_untracked = true,
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
        theme = 'dropdown',
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
    },
  }

  telescope.setup(configsTelescope)

  telescope.load_extension('fzf')
  telescope.load_extension('projects')
  telescope.load_extension('notify')
  telescope.load_extension('git_worktree')
  telescope.load_extension('refactoring')
  -- telescope.load_extension("ui-select")
end

return M
