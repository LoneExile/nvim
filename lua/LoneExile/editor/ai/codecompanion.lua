local M = {}

M.keys = {
  {
    '<leader>c',
    '',
    desc = 'Copilot',
    mode = 'n',
  },
  {
    '<leader>cn',
    '<cmd>CodeCompanionChat Toggle<CR>',
    desc = 'Companion Chat',
    mode = 'n',
  },
  {
    '<leader>cA',
    '<cmd>CodeCompanionActions<CR>',
    desc = 'Companion Actions',
    mode = { 'n', 'v' },
  },
}

M.setup = function()
  return {
    'olimorris/codecompanion.nvim',
    cmd = { 'CodeCompanionChat', 'CodeCompanionActions', 'CodeCompanion' },
    keys = M.keys,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'ravitemer/mcphub.nvim',
      'HakonHarnes/img-clip.nvim',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'codecompanion' },
        },
        ft = { 'markdown', 'codecompanion' },
      },
    },
    config = function()
      require('codecompanion').setup({
        extensions = {
          mcphub = {
            callback = 'mcphub.extensions.codecompanion',
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true,
            },
          },
        },
        opts = {
          -- NOTE: The log_level is in `opts.opts`
          log_level = 'DEBUG', -- or "TRACE"
        },
        adapters = {
          http = {
            anthropic = function()
              return require('codecompanion.adapters').extend('anthropic', {
                env = {
                  api_key = 'ANTHROPIC_API_KEY',
                },
              })
            end,
          },
        },
        strategies = {
          chat = {
            name = 'copilot',
            model = 'gpt-4.1',
          },
          inline = {
            adapter = 'copilot',
          },
        },
      })
    end,
  }
end

return M
