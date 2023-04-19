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

M.setup = function(settings, _)
  return {
    'jackMort/ChatGPT.nvim',
    enabled = M.enabled,
    cmd = { 'ChatGPT' },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require(settings.env_file)
      local status_GPT, chatgpt = pcall(require, 'chatgpt')
      if not status_GPT or vim.env.OPENAI_API_KEY == nil then
        return
      end
      chatgpt.setup()
    end,
  }
end

return M
