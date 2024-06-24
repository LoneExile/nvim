local M = {}

M.wh_key = {
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
    event = { 'BufRead', 'BufNewFile' },

    config = function()
      local status_ok_ui, gitsigns = pcall(require, 'gitsigns')
      if not status_ok_ui then
        return
      end

      gitsigns.setup({
        signs = {
          add = { text = '┃' },
          change = { text = '┃' },
          delete = { text = ' ' },
          topdelete = { text = ' ' },
          changedelete = { text = '~' },
          untracked = { text = '┆' },
        },
        numhl = false,
        linehl = false,
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
      })
    end,
  }
end

return M
