local M = {}

M.setup = function(settings, _)
  return {
    'jackMort/ChatGPT.nvim',
    cmd = { 'ChatGPT' },
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
