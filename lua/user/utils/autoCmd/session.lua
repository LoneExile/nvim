local config_group = vim.api.nvim_create_augroup('MyConfigGroup', {}) -- A global group for all your config autocommands

vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'SessionLoadPost',
  group = config_group,
  callback = function()
    vim.cmd('LspRestart')
  end,
})
