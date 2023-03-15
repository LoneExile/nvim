local M = {}

M.setup = function(settings, _)
  return {
    'jackMort/ChatGPT.nvim',
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
