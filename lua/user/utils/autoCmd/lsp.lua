local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local group = augroup('diagnostic_cmds', { clear = true })

autocmd('ModeChanged', {
  group = group,
  pattern = { 'n:i', 'v:s' },
  desc = 'Disable diagnostics while typing',
  callback = function()
    vim.diagnostic.disable(0)
  end,
})

autocmd('ModeChanged', {
  group = group,
  pattern = 'i:n',
  desc = 'Enable diagnostics when leaving insert mode',
  callback = function()
    vim.diagnostic.enable(0)
  end,
})
