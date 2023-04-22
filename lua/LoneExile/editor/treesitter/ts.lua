local M = {}

M.setup = function(_, location)
  location = vim.fn.substitute(location, '.ts$', '', 'g')
  return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'mrjones2014/nvim-ts-rainbow',
      'RRethy/nvim-treesitter-textsubjects',
      'andymass/vim-matchup',
    },
    event = 'BufRead',
    build = function()
      ---@diagnostic disable-next-line: param-type-mismatch
      pcall(vim.cmd, 'TSUpdate')
    end,
    config = function()
      local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
      if not status_ok then
        return
      end

      local status, commentConfig = pcall(require, location .. '.settings.commentString')
      if not status then
        commentConfig = {}
        vim.notify('Treesitter comment config not found')
      end

      local tsTextObjects = require(location .. '.settings.tsTextObjects')

      configs.setup({
        -- ensure_installed = 'all',
        ensure_installed = {
          'markdown',
          'markdown_inline',
          'javascript',
          'typescript',
          'vue',
          'tsx',
          'css',
          'html',
          'json',
          'toml',
          'lua',
          'python',
          'bash',
          'yaml',
          'c',
          'cpp',
          'c_sharp',
          'rust',
        },
        sync_install = false,
        auto_install = true,
        ignore_install = { '' },
        highlight = {
          enable = true,
          disable = { '' },
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true, disable = { 'python', 'css' } },

        -- **nvim-ts-context-commentstring**
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
          config = commentConfig,
        },

        -- **nvim-ts-rainbow**
        rainbow = {
          enable = true,
          -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
          -- termcolors = {} -- table of colour name strings
          colors = {
            '#68a0b0',
            '#946EaD',
            '#c7aA6D',
            'Gold',
            'Orchid',
            'DodgerBlue',
            'Cornsilk',
            'Salmon',
            'LawnGreen',
          },
          disable = { 'html' },
        },

        -- ** textobjects **
        textobjects = tsTextObjects,

        -- ** ts autopairs **
        autopairs = { enable = true },

        -- ** nvim-treesitter-textsubjects **
        textsubjects = {
          enable = true,
          prev_selection = ',', -- (Optional) keymap to select the previous selection
          keymaps = {
            ['.'] = 'textsubjects-smart',
            -- [";"] = "textsubjects-container-outer",
            -- ["i;"] = "textsubjects-container-inner",
          },
        },

        -- matchup
        matchup = {
          enable = true, -- mandatory, false will disable the whole extension
          disable = { 'c', 'ruby' }, -- optional, list of language that will be disabled
          -- [options]
        },

        -- ** markid ** better highlight (currently suck!?)
        -- markid = { enable = false },
      })
    end,
  }
end

return M
