local M = {}

M.keys = {
  {
    'mt',
    '<cmd>MarksToggleSigns<cr>',
    desc = 'Mark Toggle',
    mode = 'n',
  },
  {
    'ml',
    '<cmd>MarksListBuf<cr>',
    desc = 'Mark List',
    mode = 'n',
  },
  {
    'md',
    '<Plug>(Marks-deleteline)',
    desc = 'Mark Delete',
    mode = 'n',
  },
  {
    'mD',
    '<Plug>(Marks-deletebuf)',
    desc = 'Mark Delete Buf',
    mode = 'n',
  },
  {
    'mp',
    '<Plug>(Marks-preview)',
    desc = 'Mark Preview',
    mode = 'n',
  },
  {
    'mj',
    '<Plug>(Marks-next)',
    desc = 'Mark Next',
    mode = 'n',
  },
  {
    'mk',
    '<Plug>(Marks-prev)',
    desc = 'Mark Prev',
    mode = 'n',
  },
  {
    'ms',
    '<Plug>(Marks-set)',
    desc = 'Mark Set',
    mode = 'n',
  },
}

M.setup = function()
  return {
    'chentoast/marks.nvim',
    event = 'BufRead',
    keys = M.keys,
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
