local group = vim.api.nvim_create_augroup('autocmd_cs', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cs' },
  callback = function()
    vim.api.nvim_set_keymap(
      'n',
      '<leader>lD',
      '<cmd>lua require("omnisharp_extended").lsp_definitions()<CR>',
      { noremap = true, silent = true, desc = 'Go to definition' }
    )
  end,
  group = group,
})
