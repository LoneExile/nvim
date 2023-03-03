local M = {}

-- FIX: this should be in main config ts?
local status_ok, commmentStr = pcall(require, 'ts_context_commentstring.internal')
if not status_ok then
  vim.notify('Installing Treesitter... \nplesae restart nvim after install is complete')
  return
end

local status, tsComment = pcall(require, 'ts_context_commentstring.utils')
if not status then
  return
end

M.configs = {
  javascript = {
    __default = '// %s',
    jsx_element = '{/* %s */}',
    jsx_fragment = '{/* %s */}',
    jsx_attribute = '// %s',
    comment = '// %s',
  },
  css = '// %s',
  typescript = { __default = '// %s', __multiline = '/* %s */' },
}

commmentStr.update_commentstring({
  key = '__multiline',
})

commmentStr.calculate_commentstring({
  location = tsComment.get_cursor_location(),
})

return M.configs
