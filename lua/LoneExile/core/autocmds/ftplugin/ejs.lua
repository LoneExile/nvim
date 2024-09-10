local group = vim.api.nvim_create_augroup('autocmd_ejs', { clear = true })

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.ejs',
  callback = function()
    vim.bo.filetype = 'ejs'
  end,
  group = group,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ejs',
  callback = function()
    require('nvim-treesitter.highlight').attach(0, 'embedded_template')
  end,
  group = group,
})
