local M = {}

M.keys = {
  {
    '<leader>c',
    '',
    desc = 'Copilot',
    mode = 'n',
  },
  {
    '<leader>cc',
    function()
      require('CopilotChat').toggle()
    end,
    desc = 'Chat',
    mode = 'n',
  },
  {
    '<leader>cb',
    function()
      local input = vim.fn.input('Quick Chat: ')
      if input ~= '' then
        require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
      end
    end,
    desc = 'Chat buff',
    mode = 'n',
  },
  {
    '<leader>ch',
    function()
      local actions = require('CopilotChat.actions')
      require('CopilotChat.integrations.fzflua').pick(actions.help_actions())
    end,
    desc = 'Help actions',
    mode = 'n',
  },
  {
    '<leader>cp',
    function()
      local actions = require('CopilotChat.actions')
      require('CopilotChat.integrations.fzflua').pick(actions.prompt_actions())
    end,
    desc = 'Prompt actions',
    mode = 'n',
  },
  -- CopilotChatAgents
  {
    '<leader>cs',
    '<cmd>CopilotChatAgents<CR>',
    desc = 'Copilot Switch Provider',
  },
}

M.setup = function()
  return {
    'CopilotC-Nvim/CopilotChat.nvim',
    -- branch = 'canary',
    event = { 'BufReadPre', 'InsertEnter' },
    -- commit = '17da917aca96146189badf500a53d6d9aa853648',
    keys = M.keys,
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = 'make tiktoken',
    config = function()
      local status_ok, copilot = pcall(require, 'CopilotChat')
      if not status_ok then
        return
      end

      copilot.setup({
        chat_autocomplete = true,
        debug = true, -- Enable debugging
        show_help = true,
        question_header = '## User ', -- Header to use for user questions
        answer_header = '## LLM ', -- Header to use for AI answers
        error_header = '## Error ', -- Header to use for errors
        separator = '───', -- Separator to use in chat
        window = {
          layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
          width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
          height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
          -- Options below only apply to floating windows
          relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
          border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
          row = nil, -- row position of the window, default is centered
          col = nil, -- column position of the window, default is centered
          title = 'Chat', -- title of chat window
          footer = nil, -- footer of chat window
          zindex = 1, -- determines if window is on top or below other floating windows
        },
        mappings = {
          reset = {
            normal = '<C-x>',
            insert = '<C-x>',
          },
        },
      })
    end,
  }
end

return M
