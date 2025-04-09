local M = {}

M.keys = {
  -- {
  --   '<leader>a',
  --   '',
  --   desc = 'Avante',
  --   mode = 'n',
  -- },
  {
    '<leader>c',
    '',
    desc = 'Copilot',
    mode = { 'n', 'v' },
  },
  {
    '<leader>ca',
    '<cmd>AvanteAsk<CR>',
    desc = 'Ask',
    mode = 'n',
  },
  -- AvanteEdit
  {
    '<leader>ce',
    '<cmd>AvanteEdit<CR>',
    desc = 'Edit',
    mode = 'v',
  },
  {
    '<leader>cC',
    '<cmd>AvanteClear<CR>',
    desc = 'Clear',
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
    '<cmd>AvanteStop<CR>',
    desc = 'Stop',
    mode = 'n',
  },
  {
    '<leader>cx',
    '<cmd>AvanteModels<CR>',
    desc = 'Avante Switch Provider',
  },
}

M.setup = function()
  vim.fn.setenv('ANTHROPIC_API_KEY', vim.env.ANTHROPIC_API_KEY)
  vim.fn.setenv('OPENAI_API_KEY', vim.env.OPENAI_API_KEY)
  vim.fn.setenv('GEMINI_API_KEY', vim.env.GEMINI_API_KEY)
  vim.fn.setenv('TAVILY_API_KEY', vim.env.TAVILY_API_KEY)
  return {
    'yetone/avante.nvim',
    -- cmd = { 'AvanteAsk', 'AvanteEdit'  },
    event = 'VeryLazy',
    lazy = false,
    build = 'make',
    keys = M.keys,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
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
        -- event = 'VeryLazy',
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
      hints = { enabled = false },
      windows = {
        edit = {
          border = 'rounded',
          start_insert = false,
        },
        ask = {
          start_insert = false,
        },
      },
    },
  }
end

return M
