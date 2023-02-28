local M = {}

M.setup = function(_, _)
  return {
    'zbirenbaum/copilot.lua',
    event = { 'VimEnter' },
    config = function()
      local status_ok, copilot = pcall(require, 'copilot')
      if not status_ok then
        return
      end

      vim.schedule(function()
        copilot.setup({
          panel = { -- no config options yet
            enabled = true,
            auto_refresh = false,
            keymap = {
              -- jump_prev = '[[',
              -- jump_next = ']]',
              -- accept = '<CR>',
              -- refresh = 'gr',
              -- open = '<M-CR>',
            },
          },
          filetypes = {
            yaml = true,
            markdown = true,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = true,
            ['.'] = false,
          },
          suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 75,
            keymap = {
              accept = '<M-a>',
              accept_word = '<M-w>',
              accept_line = '<M-l>',
              next = '<C-.>',
              prev = '<C-,>',
              dismiss = '<C-e>',
            },
          },
          copilot_node_command = 'node', -- Node version must be < 18
          -- plugin_manager_path = vim.fn.expand('$HOME') .. '/.local/share/nvim/site/pack/packer',
          plugin_manager_path = vim.fn.stdpath('data') .. '/lazy',
          server_opts_overrides = {},
        })

        -- cmp.event:on('menu_opened', function()
        --   vim.b.copilot_suggestion_hidden = true
        -- end)
        --
        -- cmp.event:on('menu_closed', function()
        --   vim.b.copilot_suggestion_hidden = false
        -- end)
      end)
    end,
  }
end

return M
