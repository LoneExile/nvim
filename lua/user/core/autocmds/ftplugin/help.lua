local group = vim.api.nvim_create_augroup('autocmd_help', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = {
    'help',
  },
  callback = function(event)
    -- Open help vertically and press q to exit
    vim.api.nvim_cmd({ cmd = 'wincmd', args = { 'L' } }, {})

    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<CMD>q<CR>', { buffer = event.buf, silent = true })
  end,
})
