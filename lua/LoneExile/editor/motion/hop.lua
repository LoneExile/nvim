local M = {}

M.keys = {
  {
    'gh',
    '<CMD>HopWord<CR>',
    desc = 'HopWord',
    mode = 'n',
  },
}

M.setup = function()
  return {
    'phaazon/hop.nvim',
    event = 'BufRead',
    cmd = { 'HopWord' },
    keys = M.keys,
    config = function()
      -- local keymap = vim.api.nvim_set_keymap
      -- local opts = { noremap = true, silent = true }

      -- local hopMap = '<cmd>lua require"hop".hint_char1({ direction = require"hop.hint".'
      -- keymap('', 'f', hopMap .. 'HintDirection.AFTER_CURSOR, current_line_only = true })<cr>', opts)
      -- keymap('', 'F', hopMap .. 'HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>', opts)
      -- keymap('', 't', hopMap .. 'HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>', opts)
      -- keymap('', 'T', hopMap .. 'HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>', opts)

      local status_ok, hop = pcall(require, 'hop')
      if not status_ok then
        return
      end

      hop.setup({ keys = 'etovxqpdygfblzhckisuran' })
    end,
  }
end

return M
