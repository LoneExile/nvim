local M = {}
M.enabled = false

M.setup = function(settings, _)
  return {
    'dense-analysis/neural',
    enabled = M.enabled,
    config = function()
      require(settings.root .. '.utils.init_env')
      local status_neural, neural = pcall(require, 'neural')
      if not status_neural or vim.env.OPENAI_API_KEY == nil then
        return
      end
      neural.setup({
        mappings = {
          swift = '<C-n>', -- Context completion
          prompt = '<C-space>', -- Open prompt
        },
        open_ai = {
          api_key = vim.env.OPENAI_API_KEY,
        },
      })
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'ElPiloto/significant.nvim',
    },
  }
end

return M
