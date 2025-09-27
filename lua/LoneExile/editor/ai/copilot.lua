local M = {}

M.keys = {
  {
    '<leader>c',
    '',
    desc = 'Copilot',
    mode = 'n',
  },
  -- {
  --   '<leader>cP',
  --   '<cmd>Copilot panel<cr>',
  --   desc = 'panel',
  --   mode = 'n',
  -- },
}

M.setup = function(settings, _)
  return {
    'zbirenbaum/copilot.lua',
    event = { 'BufReadPre', 'InsertEnter' },
    keys = M.keys,
    config = function()
      local status_ok, copilot = pcall(require, 'copilot')
      if not status_ok then
        return
      end

      vim.schedule(function()
        copilot.setup({
          server_opts_overrides = {
            trace = 'verbose',
            settings = {
              advanced = {
                listCount = 5, -- #completions for panel
                inlineSuggestCount = 3, -- #completions for getCompletions
              },
            },
          },
          panel = { -- no config options yet
            enabled = true,
            auto_refresh = false,
            keymap = {
              -- jump_prev = '<M-,>',
              -- jump_next = '<M-.>',
              accept = '<CR>',
              refresh = 'gr',
              open = '<M-CR>',
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
              accept_line = "<M-'>",
              -- accept_line = "<D-'>",
              next = '<M-.>',
              prev = '<M-,>',
              dismiss = '<C-e>',
            },
          },
          copilot_node_command = 'node', -- Node version must be < 18
          -- plugin_manager_path = vim.fn.expand('$HOME') .. '/.local/share/nvim/site/pack/packer',
          plugin_manager_path = settings.data_loc .. '/lazy',
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
