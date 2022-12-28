local M = {}

local env = vim.fn.stdpath('config') .. '/env.lua'

if vim.fn.filereadable(env) == 0 then
  local value = '-- https://beta.openai.com/account/api-keys\n vim.cmd(\'let $OPENAI_API_KEY="<PUT-YOUR-KEY-HERE>"\')'
  io.open(env, 'w'):write(value)
  io.open(env, 'w'):close()
end

if vim.fn.filereadable(env) == 1 then
  dofile(env)
end

-------------------------------------------------------------------------

M.setupGPT = function()
  local status_GPT, chatgpt = pcall(require, 'chatgpt')
  if not status_GPT or vim.env.OPENAI_API_KEY == nil then
    return
  end
  chatgpt.setup({})
end

-------------------------------------------------------------------------

M.setupNeural = function()
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
end
---------------------------------------------------------------------------

return M
