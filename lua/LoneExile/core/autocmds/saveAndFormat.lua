local M = {}

M.setup = function(_, _)
  vim.api.nvim_create_user_command('SaveNFormat', function()
    vim.cmd('Format')
    vim.cmd('w!')
  end, {})

  vim.api.nvim_create_user_command('FormatCurrentBuf', function()
    vim.lsp.buf.format()
  end, {})
end

return M
