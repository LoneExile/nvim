local M = {}
local status_ok, copilot = pcall(require, 'copilot')
if not status_ok then
  return
end

local status, cmp = pcall(require, 'copilot_cmp')
if not status then
  return
end

M.setup = function()
  copilot.setup({
    panel = { -- no config options yet
      enabled = true,
      -- auto_refresh = false,
      -- keymap = {
      --   jump_prev = '[[',
      --   jump_next = ']]',
      --   accept = '<CR>',
      --   refresh = 'gr',
      --   open = '<M-CR>',
      -- },
    },
    ft_disable = { 'alpha', 'neo-tree' },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = '<C-a>',
        next = '<C-.>',
        prev = '<C-,>',
        dismiss = '<C-e>',
      },
    },
    copilot_node_command = 'node', -- Node version must be < 18
    -- plugin_manager_path = vim.fn.expand('$HOME') .. '/.local/share/nvim/site/pack/packer',
    plugin_manager_path = vim.fn.stdpath('data') .. '/site/pack/packer',
    server_opts_overrides = {},
  })

  -- cmp.event:on('menu_opened', function()
  --   vim.b.copilot_suggestion_hidden = true
  -- end)
  --
  -- cmp.event:on('menu_closed', function()
  --   vim.b.copilot_suggestion_hidden = false
  -- end)
end

M.cmpSetup = function()
  cmp.setup({
    method = 'getCompletionsCycling',
    force_autofmt = true,
    clear_after_cursor = true,
    formatters = {
      label = require('copilot_cmp.format').format_label_text,
      insert_text = require('copilot_cmp.format').format_label_text,
      preview = require('copilot_cmp.format').deindent,
    },
  })
end

return M
