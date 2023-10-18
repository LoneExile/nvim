local M = {}

M.setup = function(_, m)
  vim.api.nvim_create_user_command('SaveNFormat', function()
    if m.is_plugin_loaded(nil, 'conform.nvim') then
      vim.cmd('Format')
    else
      vim.lsp.buf.format()
    end

    vim.cmd('w!')
  end, {})

  vim.api.nvim_create_user_command('FormatCurrentBuf', function()
    vim.lsp.buf.format()
  end, {})
end

return M
