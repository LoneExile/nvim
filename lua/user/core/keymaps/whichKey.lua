local M = {}

local status_ok, whichkey = pcall(require, 'which-key')
if not status_ok then
  return
end

function M.setup()
  local conf = {
    plugins = {
      marks = true,
      registers = true,
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
      spelling = { enabled = true, suggestions = 20 },
    },
    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = '➜', -- symbol used between a key and it's label
      group = '+', -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = '<c-d>',
      scroll_up = '<c-u>',
    },
    window = {
      border = 'single',
      position = 'bottom',
      margin = { 1, 0, 1, 0 },
      padding = { 0, 0, 0, 0 },
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 20 },
      width = { min = 20, max = 30 },
      spacing = 2,
      align = 'left',
    },
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    show_help = false,
    triggers = 'auto',
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      i = { 'j', 'k' },
      v = { 'j', 'k' },
    },
    disable = {
      -- buftypes = { '*' },
      -- filetypes = { '*' },
    },
  }

  local location = 'user.core.keymaps.'
  local split_mappings = require(location .. 'utils').split_mappings
  local mappings = require(location .. 'key_leader').mappings
  local m_mappings = require(location .. 'key_m').m_mppings

  local opts = require(location .. 'key_leader').opts
  local vopts = require(location .. 'key_leader').vopts
  local m_opts = require(location .. 'key_m').m_opts

  local fileType = vim.api.nvim_buf_get_option(0, 'filetype')
  local nmappings, vmappings, _, _ = split_mappings(mappings, fileType)

  whichkey.setup(conf)

  whichkey.register()
  whichkey.register(nmappings, opts)
  whichkey.register(vmappings, vopts)
  whichkey.register(m_mappings, m_opts)
end

return M.setup()
