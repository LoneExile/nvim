local group = vim.api.nvim_create_augroup('close_with_q', { clear = true })

-- :lua print(vim.bo.filetype)
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = {
    'PlenaryTestPopup',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'tsplayground',
    'checkhealth',
    'neotest-output-panel',
    'neotest-output',
    'neotest-summary',
    'aerial-nav',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})
