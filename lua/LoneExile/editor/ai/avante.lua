local M = {}

M.keys = {
  {
    '<leader>a',
    function()
      local status, wk = pcall(require, 'which-key')
      if not status then
        return
      end
      wk.show({ global = false })
    end,
    desc = 'Avante',
    mode = 'n',
  },
  {
    '<leader>c',
    function()
      local status, wk = pcall(require, 'which-key')
      if not status then
        return
      end
      wk.show({ global = false })
    end,
    desc = 'Copilot',
    mode = 'n',
  },
  {
    '<leader>ca',
    '<cmd>AvanteAsk<CR>',
    desc = 'Ask',
    mode = 'n',
  },
  {
    '<leader>cn',
    '<cmd>AvanteConflictNextConflict<CR>',
    desc = 'Next Conflict',
    mode = 'n',
  },
  {
    '<leader>cp',
    '<cmd>AvanteConflictPrevConflict<CR>',
    desc = 'Prev Conflict',
    mode = 'n',
  },
  {
    '<leader>cs',
    function()
      local status, wk = pcall(require, 'which-key')
      if not status then
        return
      end
      wk.show({ global = false })
    end,
    desc = 'Switch Provider',
  },
  {
    '<leader>cso',
    '<cmd>AvanteSwitchProvider openai<CR>',
    desc = 'OpenAI',
    mode = 'n',
  },
  {
    '<leader>csc',
    '<cmd>AvanteSwitchProvider claude<CR>',
    desc = 'Claude',
    mode = 'n',
  },
  {
    '<leader>csp',
    '<cmd>AvanteSwitchProvider copilot<CR>',
    desc = 'Copilot',
    mode = 'n',
  },
  {
    '<leader>csg',
    '<cmd>AvanteSwitchProvider gemini<CR>',
    desc = 'Gemini',
    mode = 'n',
  },
}

M.setup = function()
  vim.fn.setenv('ANTHROPIC_API_KEY', vim.env.ANTHROPIC_API_KEY)
  vim.fn.setenv('OPENAI_API_KEY', vim.env.OPENAI_API_KEY)
  vim.fn.setenv('GEMINI_API_KEY', vim.env.GEMINI_API_KEY)
  return {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    build = 'make',
    keys = M.keys,
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
      provider = 'claude',
      -- provider = 'copilot',
      behaviour = {
        auto_set_keymaps = false,
      },
      -- mappings = {
      --   ask = '<leader>ca',
      --   edit = '<leader>ce',
      --   refresh = '<leader>cr',
      --   --- @class AvanteConflictMappings
      --   diff = {
      --     ours = 'co',
      --     theirs = 'ct',
      --     both = 'cb',
      --     next = ']x',
      --     prev = '[x',
      --   },
      --   jump = {
      --     next = ']]',
      --     prev = '[[',
      --   },
      --   submit = {
      --     normal = '<CR>',
      --     insert = '<C-s>',
      --   },
      --   toggle = {
      --     debug = '<leader>ad',
      --     hint = '<leader>ah',
      --   },
      -- },
      hints = { enabled = false },
    },
  }
end

return M
