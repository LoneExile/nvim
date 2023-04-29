local M = {}

M.setup = function()
  return {
    'nmac427/guess-indent.nvim',
    config = function()
      local status_ok, guess_indent = pcall(require, 'guess-indent')
      if not status_ok then
        return
      end

      guess_indent.setup({
        auto_cmd = true, -- Set to false to disable automatic execution
        override_editorconfig = false, -- Set to true to override settings set by .editorconfig
        filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
          'netrw',
          'tutor',
        },
        buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
          'help',
          'nofile',
          'terminal',
          'prompt',
        },
      })
    end,
  }
end

return M
