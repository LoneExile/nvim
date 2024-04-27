local M = {}

-- M.wh_key = {
--   wh_mappings = {
--     ['/'] = {
--       cmd = {
--         -- n = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
--         -- v = '<Plug>(comment_toggle_linewise_visual)',
--         n = function()
--           local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
--           local api = require('Comment.api')
--           vim.api.nvim_feedkeys(esc, 'nx', false)
--           api.toggle.linewise.current()
--         end,
--         --[[ v = function()
--           local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
--           local api = require('Comment.api')
--           vim.api.nvim_feedkeys(esc, 'nx', false)
--           api.toggle.blockwise(vim.fn.visualmode())
--         end, ]]
--         v = '<Plug>(comment_toggle_linewise_visual)',
--       },
--       'Comment',
--       mode = { 'n', 'v' },
--       ft = { only = {}, exclude = { 'alpha', 'neo-tree' } },
--     },
--   },
-- }

M.setup = function(_, _)
  return {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'InsertEnter' },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      local status_ok, comment = pcall(require, 'Comment')
      if not status_ok then
        return
      end

      local ft = require('Comment.ft')
      ft.set('templ', { '// %s', '<!-- %s -->' })

      local configs = {
        padding = true,
        sticky = true,
        ignore = '^$',
        toggler = {
          line = 'gcc',
          block = 'gbc',
        },
        opleader = {
          line = 'gc',
          block = 'gb',
        },
        extra = {
          above = 'gcO',
          below = 'gco',
          eol = 'gcA',
        },
        mappings = {
          basic = true,
          extra = true,
          extended = false,
        },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        post_hook = nil,
      }

      comment.setup(configs)
    end,
  }
end

return M
