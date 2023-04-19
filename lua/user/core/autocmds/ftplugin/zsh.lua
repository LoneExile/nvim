local group = vim.api.nvim_create_augroup('autocmd_zsh', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'zsh',
  callback = function()
    require('nvim-treesitter.highlight').attach(0, 'bash')
  end,
  group = group,
})
