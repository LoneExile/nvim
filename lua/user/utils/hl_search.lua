return function(blinktime)
  local ns = vim.api.nvim_create_namespace('search')
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

  local search_pat = '\\c\\%#' .. vim.fn.getreg('/')
  local m = vim.fn.matchadd('IncSearch', search_pat)
  vim.cmd('redraw')
  vim.cmd('sleep ' .. blinktime * 1000 .. 'm')

  local sc = vim.fn.searchcount()
  vim.api.nvim_buf_set_extmark(0, ns, vim.api.nvim_win_get_cursor(0)[1] - 1, 0, {
    virt_text = { { '[' .. sc.current .. '/' .. sc.total .. ']', 'Comment' } },
    virt_text_pos = 'eol',
  })

  vim.fn.matchdelete(m)
  vim.cmd('redraw')
end

-- nnoremap n nzz:lua require("functions").hl_search(0.3)<CR>
-- nnoremap N Nzz:lua require("functions").hl_search(0.3)<CR>
