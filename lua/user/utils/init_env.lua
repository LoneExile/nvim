local env = vim.fn.stdpath('config') .. '/.env.lua'

-- if you don't export the env in your shell, it will generate file .env.lua in your config folder
if vim.fn.filereadable(env) == 0 and vim.env.OPENAI_API_KEY == nil then
  local value = '-- https://beta.openai.com/account/api-keys\n vim.cmd(\'let $OPENAI_API_KEY="<PUT-YOUR-KEY-HERE>"\')'
  io.open(env, 'w'):write(value)
  io.open(env, 'w'):close()
end

if vim.fn.filereadable(env) == 1 then
  dofile(env)
end
