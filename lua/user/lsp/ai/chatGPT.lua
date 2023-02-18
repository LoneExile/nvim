local M = {}

M.setup = function(settings, location)
  return {
    'jackMort/ChatGPT.nvim',
    config = function()
      local status_GPT, chatgpt = pcall(require, 'chatgpt')
      if not status_GPT or vim.env.OPENAI_API_KEY == nil then
        return
      end
      settings.env_file()
      chatgpt.setup({})
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  }
end

return M
