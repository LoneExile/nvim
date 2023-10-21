local M = {}

M.wh_key = {
  wh_mappings = {
    c = {
      name = '+ChatGPT',
      c = { '<cmd>ChatGPT<cr>', 'ChatGPT', mode = { 'n' } },
      a = { '<cmd>ChatGPTActAs<cr>', 'GPTActAs', mode = { 'n' } },
      i = { '<cmd>ChatGPTEditWithInstructions<cr>', 'GPTInstructions', mode = { 'n', 'v' } },
      r = {
        name = '+ChatGPTRun',
        g = { '<cmd>ChatGPTRun grammar_correction<cr>', 'Grammar', mode = { 'n', 'v' } },
        T = { '<cmd>ChatGPTRun translate<cr>', 'Translate', mode = { 'n', 'v' } },
        k = { '<cmd>ChatGPTRun keywords<cr>', 'Keywords', mode = { 'n', 'v' } },
        d = { '<cmd>ChatGPTRun docstring<cr>', 'Docstring', mode = { 'n', 'v' } },
        t = { '<cmd>ChatGPTRun add_tests<cr>', 'AddTests', mode = { 'n', 'v' } },
        o = { '<cmd>ChatGPTRun optimize_code<cr>', 'OptimizeCode', mode = { 'n', 'v' } },
        s = { '<cmd>ChatGPTRun summarize<cr>', 'Summarize', mode = { 'n', 'v' } },
        f = { '<cmd>ChatGPTRun fix_bugs<cr>', 'FixBugs', mode = { 'n', 'v' } },
        e = { '<cmd>ChatGPTRun explain_code<cr>', 'ExplainCode', mode = { 'n', 'v' } },
        -- r = { '<cmd>ChatGPTRun roxygen_edit<cr>', 'RoxygenEdit', mode = { 'n', 'v' } },
        c = { '<cmd>ChatGPTRun code_readability_analysis<cr>', 'CodeReadabilityAnalysis', mode = { 'n', 'v' } },
      },
    },
  },
}

M.setup = function(settings, _)
  return {
    'jackMort/ChatGPT.nvim',
    cmd = { 'ChatGPT', 'ChatGPTActAs', 'ChatGPTEditWithInstructions' },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require(settings.root .. '.utils.init_env')
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
        popup_layout = {
          default = 'right',
        },
        popup_window = {
          border = {
            highlight = 'FloatBorder',
            style = 'rounded',
            text = {
              top = ' Teddy ',
            },
          },
        },
        openai_params = {
          -- model = 'gpt-3.5-turbo',
          model = 'gpt-4',
        },
        openai_edit_params = {
          -- model = "gpt-3.5-turbo",
          model = 'gpt-4',
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
