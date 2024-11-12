local M = {}

M.keys = {
  {
    '<leader>g',
    '',
    desc = 'Git',
    mode = 'n',
  },
  {
    '<leader>gS',
    '<cmd>lua require "gitsigns".stage_buffer()<cr>',
    desc = 'Stage Buffer',
    mode = 'n',
  },
  {
    '<leader>gj',
    '<cmd>lua require "gitsigns".next_hunk()<cr>',
    desc = 'Next Hunk',
    mode = 'n',
  },
  {
    '<leader>gk',
    '<cmd>lua require "gitsigns".prev_hunk()<cr>',
    desc = 'Prev Hunk',
    mode = 'n',
  },
  {
    '<leader>gl',
    '<cmd>lua require "gitsigns".blame_line()<cr>',
    desc = 'Blame',
    mode = 'n',
  },
  {
    '<leader>gp',
    '<cmd>lua require "gitsigns".preview_hunk()<cr>',
    desc = 'Preview Hunk',
    mode = 'n',
  },
  {
    '<leader>gr',
    '<cmd>lua require "gitsigns".reset_hunk()<cr>',
    desc = 'Reset Hunk',
    mode = 'n',
  },
  {
    '<leader>gR',
    '<cmd>lua require "gitsigns".reset_buffer()<cr>',
    desc = 'Reset Buffer',
    mode = 'n',
  },
  {
    '<leader>gs',
    '<cmd>lua require "gitsigns".stage_hunk()<cr>',
    desc = 'Stage Hunk',
    mode = 'n',
  },
  {
    '<leader>gu',
    '<cmd>lua require "gitsigns".undo_stage_hunk()<cr>',
    desc = 'Undo Stage Hunk',
    mode = 'n',
  },
}

M.setup = function()
  return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead', 'BufNewFile' },
    keys = M.keys,

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
