local M = {}

M.setup = function()
  return {
    'metakirby5/codi.vim',
    enabled = false,
    lazy = true,
    cmd = 'Codi',
    config = function()
      vim.g['codi#virtual_text_prefix'] = '❯❯❯ '
      vim.g['codi#virtual_text_pos'] = 100
      --------------------------------------------------------------
      -- " let g:codi#virtual_text = 0  "0 split to right in nvim"
      -- " let g:codi#rightalign = 0 "0 spawn on thr left side"
      --------------------------------------------------------------
      -- " let g:codi#aliases = {
      -- "                    \ 'javascript.jsx': 'javascript',
      -- "                    \ 'js': 'javascript',
      -- "                    \ }
    end,
  }
end

return M
