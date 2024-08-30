local M = {}

M.wh_key = {
  wh_mappings = {
    c = {
      name = 'Copilot',
      -- c = {
      --   '<cmd>AvanteAsk<CR>',
      --   'Chat',
      --   mode = { 'n', 'v' },
      -- },
      n = {
        '<cmd>AvanteConflictNextConflict<CR>',
        'Next Conflict',
        mode = { 'n' },
      },
      p = {
        '<cmd>AvanteConflictPrevConflict<CR>',
        'Prev Conflict',
        mode = { 'n' },
      },
      s = {
        name = 'Switch Provider',
        o = {
          '<cmd>AvanteSwitchProvider openai<CR>',
          'OpenAI',
          mode = { 'n' },
        },
        c = {
          '<cmd>AvanteSwitchProvider claude<CR>',
          'Claude',
          mode = { 'n' },
        },
        p = {
          '<cmd>AvanteSwitchProvider copilot<CR>',
          'Copilot',
          mode = { 'n' },
        },
        g = {
          '<cmd>AvanteSwitchProvider gemini<CR>',
          'Gemini',
          mode = { 'n' },
        },
      },
    },
  },
}

M.setup = function()
  vim.fn.setenv('ANTHROPIC_API_KEY', vim.env.ANTHROPIC_API_KEY)
  vim.fn.setenv('OPENAI_API_KEY', vim.env.OPENAI_API_KEY)
  vim.fn.setenv('GEMINI_API_KEY', vim.env.GEMINI_API_KEY)
  return {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    -- build = 'make BUILD_FROM_SOURCE=true luajit',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'zbirenbaum/copilot.lua',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
      {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
          },
        },
      },
    },
    opts = {
      -- provider = 'claude',
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
    },
  }
end

return M
