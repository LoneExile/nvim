local group = vim.api.nvim_create_augroup('autocmd_helmignore', { clear = true })

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.helmignore',
  callback = function()
    vim.bo.filetype = 'helmignore'
  end,
  group = group,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'helmignore',
  callback = function()
    require('nvim-treesitter.highlight').attach(0, 'gitignore')
  end,
  group = group,
})
