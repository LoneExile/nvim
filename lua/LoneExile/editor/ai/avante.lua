local M = {}

M.wh_key = {
  wh_mappings = {
    c = {
      name = 'Copilot',
      c = {
        '<cmd>AvanteAsk<CR>',
        'Chat',
        mode = { 'n', 'v' },
      },
    },
  },
}

M.setup = function()
  return {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    build = 'make',
    opts = {
      provider = 'copilot',
      mappings = {
        ask = '<leader>cc',
        edit = '<leader>ce',
        refresh = '<leader>cr',
        --- @class AvanteConflictMappings
        diff = {
          ours = 'co',
          theirs = 'ct',
          both = 'cb',
          next = ']x',
          prev = '[x',
        },
        jump = {
          next = ']]',
          prev = '[[',
        },
        submit = {
          normal = '<CR>',
          insert = '<C-s>',
        },
        toggle = {
          debug = '<leader>ad',
          hint = '<leader>ah',
        },
      },
      hints = { enabled = false },
      windows = {
        wrap = true, -- similar to vim.o.wrap
        width = 30, -- default % based on available width
        sidebar_header = {
          align = 'center', -- left, center, right for title
          rounded = true,
        },
      },
      highlights = {
        ---@type AvanteConflictHighlights
        diff = {
          current = 'DiffText',
          incoming = 'DiffAdd',
        },
      },
      --- @class AvanteConflictUserConfig
      diff = {
        debug = false,
        autojump = true,
        ---@type string | fun(): any
        list_opener = 'copen',
      },
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  }
end

return M
