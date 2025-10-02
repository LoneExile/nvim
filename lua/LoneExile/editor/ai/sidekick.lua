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
    '<leader>cs',
    function()
      require('sidekick.cli').toggle({ name = 'copilot', focus = true })
    end,
    mode = { 'n', 'v' },
    desc = 'Sidekick Toggle CLI',
  },
  {
    '<leader>cs',
    function()
      require('sidekick.cli').send({ name = 'copilot', selection = true })
    end,
    mode = { 'v' },
    desc = 'Sidekick Send Visual Selection',
  },
  -- {
  --   "<leader>ap",
  --   function() require("sidekick.cli").prompt() end,
  --   mode = { "n", "v" },
  --   desc = "Sidekick Select Prompt",
  -- },
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
      },
    },
  }
end

return M
