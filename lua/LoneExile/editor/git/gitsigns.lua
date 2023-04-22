local M = {}
M.enabled = true

M.wh_key = {
  enabled = M.enabled,
  wh_mappings = {
    ['g'] = {
      name = 'Git',
      S = {
        '<cmd>lua require "gitsigns".stage_buffer()<cr>',
        'Stage Buffer',
        mode = { 'n' },
      },
      j = {
        "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
        'Next Hunk',
        mode = { 'n' },
      },
      k = {
        "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
        'Prev Hunk',
        mode = { 'n' },
      },
      l = {
        "<cmd>lua require 'gitsigns'.blame_line()<cr>",
        'Blame',
        mode = { 'n' },
      },
      p = {
        "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
        'Preview Hunk',
        mode = { 'n' },
      },
      r = {
        "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
        'Reset Hunk',
        mode = { 'n' },
      },
      R = {
        "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
        'Reset Buffer',
        mode = { 'n' },
      },
      s = {
        "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
        'Stage Hunk',
        mode = { 'n' },
      },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        'Undo Stage Hunk',
        mode = { 'n' },
      },
    },
  },
}

M.setup = function()
  return {
    'lewis6991/gitsigns.nvim',
    enabled = M.enabled,
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      local status_ok_ui, gitsigns = pcall(require, 'gitsigns')
      if not status_ok_ui then
        return
      end

      gitsigns.setup({
        signs = {
          add = {
            hl = 'GitSignsAdd',
            text = '▎',
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn',
          },
          change = {
            hl = 'GitSignsChange',
            text = '▎',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn',
          },
          delete = {
            hl = 'GitSignsDelete',
            text = '契',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn',
          },
          topdelete = {
            hl = 'GitSignsDelete',
            text = '契',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn',
          },
          changedelete = {
            hl = 'GitSignsChange',
            text = '▎',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn',
          },
        },
        numhl = false,
        linehl = false,
        keymaps = {
          -- Default keymap options
          noremap = true,
          buffer = true,
        },
        signcolumn = true,
        word_diff = false,
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter_opts = {
          relative_time = false,
        },
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'rounded',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1,
        },
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        sign_priority = 6,
        update_debounce = 200,
        status_formatter = nil, -- Use default
        yadm = { enable = false },
      })
    end,
  }
end

return M
