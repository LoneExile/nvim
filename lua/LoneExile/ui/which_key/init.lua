local M = {}

M.setup = function(settings, location)
  return {
    'folke/which-key.nvim',
    keys = { '<leader>', 'g', 'V' },
    -- event = 'BufRead',
    -- cmd = { 'WhichKey' },
    -- priority = 1000,
    config = function()
      -- vim.o.timeout = true
      -- vim.o.timeoutlen = 300
      local status_ok, which_key = pcall(require, 'which-key')
      if not status_ok then
        return
      end

      local config = {
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
          zindex = 1000,
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
        -- triggers = { '<leader>', 'g', 'm' }, -- or specify a list manually
        triggers_blacklist = {
          i = { 'j', 'k' },
          v = { 'j', 'k' },
        },
        disable = {
          -- buftypes = { '*' },
          -- filetypes = { '*' },
        },
      }

      local split_mappings = require(location .. '.utils').split_mappings
      -- local mappings = require(location .. '.key_leader').mappings
      -- local m_mappings = require(location .. '.key_m').m_mappings
      local mappings = settings.wh_mappings.mappings
      local m_mappings = settings.wh_mappings.m_mappings
      local g_mappings = settings.wh_mappings.g_mappings

      local opts = require(location .. '.key_leader').opts
      local vopts = require(location .. '.key_leader').vopts
      local m_opts = require(location .. '.key_m').m_opts

      local g_opts = require(location .. '.key_g').g_opts

      local fileType = vim.api.nvim_buf_get_option(0, 'filetype')
      local nmappings, vmappings, _, _ = split_mappings(mappings, fileType)

      which_key.setup(config)

      which_key.register()
      which_key.register(nmappings, opts)
      which_key.register(vmappings, vopts)
      which_key.register(m_mappings, m_opts)
      which_key.register(g_mappings, g_opts)
    end,
  }
end

return M
