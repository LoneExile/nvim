local M = {}

M.keys = {
  {
    '<leader>c',
    '',
    desc = 'Copilot',
    mode = 'n',
  },
  {
    '<tab>',
    function()
      -- if there is a next edit, jump to it, otherwise apply it if any
      if not require('sidekick').nes_jump_or_apply() then
        return '<Tab>' -- fallback to normal tab
      end
    end,
    expr = true,
    desc = 'Goto/Apply Next Edit Suggestion',
  },
  {
    '<leader>aa',
    function()
      require('sidekick.cli').toggle({ name = 'copilot', focus = true })
    end,
    mode = { 'n', 'v' },
    desc = 'Sidekick Toggle CLI',
  },
  {
    '<leader>ac',
    function()
      require('sidekick.cli').toggle({ name = 'claude', focus = true })
    end,
    mode = { 'n', 'v' },
    desc = 'Sidekick Toggle Claude CLI',
  },
  {
    '<leader>at',
    function()
      require('sidekick.cli').send({ msg = '{this}' })
    end,
    mode = { 'x', 'n' },
    desc = 'Send This',
  },
  {
    '<leader>af',
    function()
      require('sidekick.cli').send({ msg = '{file}' })
    end,
    desc = 'Send File',
  },
}

M.setup = function()
  return {
    'folke/sidekick.nvim',
    keys = M.keys,
    opts = {
      cli = {
        mux = {
          backend = 'tmux',
          enabled = true,
        },
        tools = {
          copilot = {
            cmd = { 'copilot', '--allow-all-tools' },
            url = 'https://github.com/github/copilot-cli',
          },
          -- claude = { cmd = { 'claude', '--dangerously-skip-permissions' } },
          claude = { cmd = { 'claude' } },
        },
      },
    },
  }
end

return M
