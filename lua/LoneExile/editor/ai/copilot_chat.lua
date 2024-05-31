local M = {}

M.wh_key = {
  wh_mappings = {
    c = {
      name = 'Copilot',
      c = {
        function()
          require('CopilotChat').toggle()
        end,
        'Chat open',
        mode = { 'n' },
      },
      r = {
        function()
          require('CopilotChat').reset()
        end,
        'Chat reset',
        mode = { 'n' },
      },
      b = {
        function()
          local input = vim.fn.input('Quick Chat: ')
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        'Chat buff',
        mode = { 'n' },
      },
      h = {
        function()
          local actions = require('CopilotChat.actions')
          require('CopilotChat.integrations.fzflua').pick(actions.help_actions())
        end,
        'Help actions',
        mode = { 'n' },
      },
      p = {
        function()
          local actions = require('CopilotChat.actions')
          require('CopilotChat.integrations.fzflua').pick(actions.prompt_actions())
        end,
        'Prompt actions',
        mode = { 'n' },
      },
    },
  },
}

M.setup = function()
  return {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    event = { 'BufReadPre', 'InsertEnter' },
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    config = function()
      local status_ok, copilot = pcall(require, 'CopilotChat')
      if not status_ok then
        return
      end

      copilot.setup({
        debug = true, -- Enable debugging
        show_help = true,
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
      require('CopilotChat.integrations.cmp').setup()
    end,
  }
end

return M
