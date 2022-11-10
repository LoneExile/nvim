local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local hopMap = '<cmd>lua require"hop".hint_char1({ direction = require"hop.hint".'

-- keymap('', 'f', hopMap .. 'HintDirection.AFTER_CURSOR, current_line_only = true })<cr>', opts)
-- keymap('', 'F', hopMap .. 'HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>', opts)
-- keymap('', 't', hopMap .. 'HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>', opts)
-- keymap('', 'T', hopMap .. 'HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>', opts)

keymap('n', 'gh', '<CMD>HopWord<CR>', opts)

local status_ok, hop = pcall(require, 'hop')
if not status_ok then
  return
end

hop.setup({ keys = 'etovxqpdygfblzhckisuran' })
