local status_ok, surround = pcall(require, 'nvim-surround')
if not status_ok then
  return
end

surround.setup({
  keymaps = {
    normal_cur = 'ss',
    normal_line = 'S',
    normal_cur_line = 'SS',
    insert = '<C-g>s',
    insert_line = '<C-g>S',
    visual = 's',
    visual_line = 'gS',
    normal = 's',
    delete = 'ds',
    change = 'cs',
  },
})
