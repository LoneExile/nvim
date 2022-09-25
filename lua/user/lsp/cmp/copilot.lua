vim.g.copilot_filetypes = { xml = false }
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap('i', '<C-a>', "copilot#Accept('<CR>')", { expr = true, silent = true })

vim.api.nvim_set_keymap('i', '<C-.>', '<Plug>(copilot-next)', { noremap = false })
vim.api.nvim_set_keymap('i', '<C-,>', '<Plug>(copilot-previous)', { noremap = false })

vim.cmd([[highlight CopilotSuggestion guifg=#555555 ctermfg=8]])

-----------------------

local status_ok, copilot = pcall(require, 'copilot')
if not status_ok then
  vim.notify('copilot' .. ' not found!')
  return
end

local config = {
  cmp = {
    enabled = true,
    method = 'getCompletionsCycling',
  },
  panel = {
    enabled = true,
  },
  ft_disable = { 'alpha' },
  plugin_manager_path = vim.fn.expand('$HOME') .. '/.local/share/nvim/site/pack/packer',
}
copilot.setup(config)
-- ----------------------------------------------------------------------------
--
-- local status_ok, copilot = pcall(require, 'copilot')
-- if not status_ok then
--   vim.notify('copilot' .. ' not found!')
--   return
-- end
--
-- local status, cmp = pcall(require, 'copilot_cmp')
-- if not status then
--   vim.notify('cmp' .. ' not found!')
--   return
-- end
--
-- copilot.setup({
--   panel = { -- no config options yet
--     enabled = true,
--   },
--   ft_disable = {},
--   copilot_node_command = 'node', -- Node version must be < 18
--   plugin_manager_path = vim.fn.stdpath('data') .. '/site/pack/packer',
--   server_opts_overrides = {},
-- })
--
-- cmp.setup({
--   method = 'getCompletionsCycling',
--   force_autofmt = false,
--   formatters = {
--     label = require('copilot_cmp.format').format_label_text,
--     insert_text = require('copilot_cmp.format').format_label_text,
--     preview = require('copilot_cmp.format').deindent,
--   },
-- })
