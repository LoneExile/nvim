local M = {}

M.setup = function(settings, location)
  return {
    'folke/which-key.nvim',
    commit = '0099511294f16b81c696004fa6a403b0ae61f7a0',
    keys = { '<leader>', 'g', 'V' },
    -- event = 'VeryLazy',
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
        preset = 'modern',
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
        layout = {
          height = { min = 4, max = 20 },
          width = { min = 20, max = 30 },
          spacing = 2,
          align = 'left',
        },
        show_help = false,
        triggers = 'auto',
        -- triggers = { '<leader>', 'g', 'm' }, -- or specify a list manually
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

      -- local fileType = vim.api.nvim_buf_get_option(0, 'filetype')
      local fileType = vim.bo.filetype
      local nmappings, vmappings, _, _ = split_mappings(mappings, fileType)

      which_key.setup(config)

      -- which_key.register()
      which_key.register(nmappings, opts)
      which_key.register(vmappings, vopts)
      which_key.register(m_mappings, m_opts)
      which_key.register(g_mappings, g_opts)
    end,
  }
end

-- 2024-07-15T15:08:38 which-key.nvim  WARN Your config uses deprecated options:
-- - `popup_mappings`
-- - `window`
-- - `ignore_missing`
-- - `hidden`
-- - `triggers_blacklist`

return M
