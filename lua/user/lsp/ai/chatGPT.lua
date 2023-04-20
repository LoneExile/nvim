local M = {}

M.enabled = true

M.wh_key = {
  enabled = M.enabled,
  wh_mappings = {
    x = {
      name = '+Execute',
      a = {
        name = '+AI',
        c = { '<cmd>ChatGPT<cr>', 'ChatGPT', mode = { 'n' } },
        a = { '<cmd>ChatGPTActAs<cr>', 'ActAs', mode = { 'n' } },
        i = { '<cmd>ChatGPTEditWithInstructions<cr>', 'Instructions', mode = { 'n', 'v' } },
      },
    },
  },
}

M.setup = function(_, _)
  return {
    'jackMort/ChatGPT.nvim',
    enabled = M.enabled,
    event = 'VeryLazy',
    cmd = { 'ChatGPT' },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('user.utils.init_env')
      local status_GPT, chatgpt = pcall(require, 'chatgpt')
      if not status_GPT or vim.env.OPENAI_API_KEY == nil then
        return
      end
      local config = {
        edit_with_instructions = {
          diff = false,
          keymaps = {
            accept = '<C-y>',
            toggle_diff = '<C-d>',
            toggle_settings = '<C-o>',
            cycle_windows = '<Tab>',
            use_output_as_input = '<C-i>',
          },
        },
        chat = {
          keymaps = {
            close = { '<C-c>' },
            yank_last = '<C-y>',
            yank_last_code = '<C-k>',
            scroll_up = '<C-u>',
            scroll_down = '<C-d>',
            toggle_settings = '<C-o>',
            new_session = '<C-n>',
            cycle_windows = '<Tab>',
            select_session = '<Space>',
            rename_session = 'r',
            delete_session = 'd',
          },
        },
      }
      chatgpt.setup(config)
    end,
  }
end

return M
