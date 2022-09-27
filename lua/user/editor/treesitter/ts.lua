local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

local commentConfig = require('user.editor.treesitter.commentString').configs
local tsTextObjects = require('user.editor.treesitter.tsTextObjects')

configs.setup({
  -- ensure_installed = 'all',
  ensure_installed = {
    'javascript',
    'typescript',
    'tsx',
    'css',
    'json',
    'lua',
    'python',
    'bash',
    'html',
    'yaml',
    'c',
    'cpp',
    'c_sharp',
    'vue',
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

  -- ** markid ** better highlight (currently suck!?)
  -- markid = { enable = false },
})
