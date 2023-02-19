local group = vim.api.nvim_create_augroup('colorAttach', { clear = true })

local events = { 'BufEnter', 'BufWinEnter', 'CursorMoved' }
vim.api.nvim_create_autocmd(events, {
  pattern = { '*' },
  callback = function()
    vim.cmd([[
    if exists('g:colorizer')
      ColorizerAttachToBuffer
    ]])
  end,
  group = group,
})
