local group = vim.api.nvim_create_augroup('autocmd_zsh', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'zsh', 'sh' },
  callback = function()
    pcall(vim.treesitter.start, 0, 'bash')
  end,
  group = group,
})
