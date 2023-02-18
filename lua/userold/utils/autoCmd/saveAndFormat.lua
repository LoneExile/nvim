-- vim.lua.buf.format({async = true})

vim.api.nvim_create_user_command('SaveNFormat', function()
  -- vim.lsp.buf.format({
  --   filter = function(client)
  --     return client.name == 'null-ls'
  --   end,
  -- })
  require('user.utils.format').format()
  vim.cmd('w!')
end, {})

vim.api.nvim_create_user_command('FormatCurrentBuf', function()
  vim.lsp.buf.format()
  -- require('user.utils.format').format()
end, {})
