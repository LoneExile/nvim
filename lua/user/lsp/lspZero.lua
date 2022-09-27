local status_ok_ui, lsp = pcall(require, 'lsp-zero')
if not status_ok_ui then
  vim.notify('LspZero not found', vim.log.levels.ERROR)
  return
end
local status_ok, navic = pcall(require, 'nvim-navic')
if not status_ok then
  vim.notify('nvim-navic' .. ' not found!')
  return
end

lsp.ensure_installed({
  'html',
  'cssls',
  'tsserver',
  'css-lsp',
})

lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = false,
  set_lsp_keymaps = false,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = false,
  call_servers = 'local',
  sign_icons = {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '',
  },
})

local add_lsp_buffer_keybindings = require('user.lsp.lspKeymaps').add_lsp_buffer_keybindings
require('user.lsp.lspSetup').severs(lsp)
require('user.lsp.integrate.mason')
require('user.lsp.cmp')

-- attach to all buffers
lsp.on_attach(function(client, bufnr)
  add_lsp_buffer_keybindings(bufnr)
  navic.attach(client, bufnr)
end)

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
lsp.setup()

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})
