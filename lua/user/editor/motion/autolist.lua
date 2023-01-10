local status, autolist = pcall(require, 'autolist')

if not status then
  return
end

autolist.setup()
autolist.create_mapping_hook('i', '<CR>', autolist.new)
autolist.create_mapping_hook('i', '<Tab>', autolist.indent)
autolist.create_mapping_hook('i', '<S-Tab>', autolist.indent, '<C-D>')
autolist.create_mapping_hook('n', 'dd', autolist.force_recalculate)
autolist.create_mapping_hook('n', 'o', autolist.new)
autolist.create_mapping_hook('n', 'O', autolist.new_before)
-- autolist.create_mapping_hook('n', '>>', autolist.indent)
-- autolist.create_mapping_hook('n', '<<', autolist.indent)
autolist.create_mapping_hook('n', '<C-q>', autolist.force_recalculate)
autolist.create_mapping_hook('n', '<leader>r', autolist.invert_entry, '')
