local status, rt = pcall(require, 'rust-tools')
if not status then
  return
end
-- require('rust-tools/executors')
local _, rt_e = pcall(require, 'rust-tools/executors')
rt.setup({
  tools = {
    executor = rt_e.termopen, -- can be quickfix or termopen
    reload_workspace_from_cargo_toml = true,
    inlay_hints = {
      auto = true,
      only_current_line = false,
      show_parameter_hints = true,
      parameter_hints_prefix = '<-',
      other_hints_prefix = '=>',
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = 'Comment',
    },
    hover_actions = {
      border = {
        { '╭', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '╮', 'FloatBorder' },
        { '│', 'FloatBorder' },
        { '╯', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '╰', 'FloatBorder' },
        { '│', 'FloatBorder' },
      },
      auto_focus = true,
    },
  },
  -- server = {
  --   on_init = require('lvim.lsp').common_on_init,
  --   on_attach = function(client, bufnr)
  --     require('lvim.lsp').common_on_attach(client, bufnr)
  --     local rt = require('rust-tools')
  --     -- Hover actions
  --     vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
  --     -- Code action groups
  --     vim.keymap.set('n', '<leader>lA', rt.code_action_group.code_action_group, { buffer = bufnr })
  --   end,
  -- },
})
