local M = {}

M.wh_key = {
  wh_m_mappings = {
    t = { '<cmd>MarksToggleSigns<cr>', 'Mark Toggle', mode = { 'n' } },
    l = { '<cmd>MarksListBuf<cr>', 'Mark List', mode = { 'n' } },
    d = { '<Plug>(Marks-deleteline)', 'Mark Delete', mode = { 'n' } },
    D = { '<Plug>(Marks-deletebuf)', 'Mark Delete Buf', mode = { 'n' } },
    p = { '<Plug>(Marks-preview)', 'Mark Preview', mode = { 'n' } },
    j = { '<Plug>(Marks-next)', 'Mark Next', mode = { 'n' } },
    k = { '<Plug>(Marks-prev)', 'Mark Prev', mode = { 'n' } },
    s = { '<Plug>(Marks-set)', 'Mark Set', mode = { 'n' } },
  },
}

M.setup = function()
  return {
    'chentoast/marks.nvim',
    event = 'BufRead',
    -- keys = { 'm' },
    config = function()
      local status_ok, mark = pcall(require, 'marks')
      if not status_ok then
        return
      end
      mark.setup({
        default_mappings = false,
      })
    end,
  }
end

return M
