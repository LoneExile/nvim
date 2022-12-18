local status_ok, chatgpt = pcall(require, 'chatgpt')

-- TODO: this not working

if vim.env.OPENAI_API_KEY == nil then
  print('Please set the OPENAI_API_KEY environment variable')
  return
else
  print('OPENAI_API_KEY is set')
end

if not status_ok then
  return
end

chatgpt.setup({})
