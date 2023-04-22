local group = vim.api.nvim_create_augroup('auto_create_dir', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = group,
  callback = function(event)
    if event.match:match('^%w%w+://') then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})
