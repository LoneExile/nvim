local M = {}

M.setup = function(_, _)
  return {
    'zbirenbaum/copilot-cmp',
    dependencies = { 'copilot.lua' },
    config = function()
      local status, cmp = pcall(require, 'copilot_cmp')
      if not status then
        return
      end
      cmp.setup({
        method = 'getCompletionsCycling',
        force_autofmt = true,
        formatters = {
          label = require('copilot_cmp.format').format_label_text,
          insert_text = require('copilot_cmp.format').format_label_text,
          preview = require('copilot_cmp.format').deindent,
        },
      })
    end,
  }
end

return M
