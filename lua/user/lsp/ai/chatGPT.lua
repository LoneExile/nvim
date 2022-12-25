local M = {}

local env = vim.fn.expand('$HOME') .. '/.config/nvim/env.lua'
dofile(env)

if vim.env.OPENAI_API_KEY == nil then
  print('Please set the OPENAI_API_KEY environment variable')
  return
end

-------------------------------------------------------------------------

local status_GPT, chatgpt = pcall(require, 'chatgpt')
if not status_GPT then
  return
end

M.setupGPT = function()
  chatgpt.setup({})
end

-------------------------------------------------------------------------

local status_neural, neural = pcall(require, 'neural')
if not status_neural then
  return
end

M.setupNeural = function()
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
-------------------------------------------------------------------------

return M
