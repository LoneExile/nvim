local M = {}

function M.smart_quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_get_option_value('modified', { buf = bufnr })
  if modified then
    vim.ui.input({
      prompt = 'You have unsaved changes. Quit anyway? (y/n) ',
    }, function(input)
      if input == 'y' then
        vim.cmd('q!')
      end
    end)
  else
    vim.cmd('confirm q')
  end
end

return M
