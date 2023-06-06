local M = {}

-- M.wh_key = {
--   wh_mappings = {
--   },
-- }

M.setup = function()
  return {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    opts = {
      animate = {
        enabled = false,
      },
      keys = {
        -- close sidebar
        ['q'] = function(win)
          win.view.edgebar:close()
        end,
      },
      -- bottom = {
      --   -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
      --   { ft = 'toggleterm', size = { height = 0.4 } },
      --   {
      --     ft = 'lazyterm',
      --     title = 'LazyTerm',
      --     size = { height = 0.4 },
      --     filter = function(buf)
      --       return not vim.b[buf].lazyterm_cmd
      --     end,
      --   },
      --   'Trouble',
      --   { ft = 'qf', title = 'QuickFix' },
      --   {
      --     ft = 'help',
      --     size = { height = 20 },
      --     -- only show help buffers
      --     filter = function(buf)
      --       return vim.bo[buf].buftype == 'help'
      --     end,
      --   },
      --   { ft = 'spectre_panel', size = { height = 0.4 } },
      -- },
      right = {
        -- Neo-tree filesystem always takes half the screen height
        {
          title = '  Files ',
          ft = 'neo-tree',
          filter = function(buf)
            return vim.b[buf].neo_tree_source == 'filesystem'
          end,
          size = { height = 0.5 },
        },
        {
          title = '  Git ',
          ft = 'neo-tree',
          filter = function(buf)
            return vim.b[buf].neo_tree_source == 'git_status'
          end,
          pinned = true,
          open = 'Neotree position=right git_status',
        },
        {
          title = '  Buffs ',
          ft = 'neo-tree',
          filter = function(buf)
            return vim.b[buf].neo_tree_source == 'buffers'
          end,
          pinned = true,
          open = 'Neotree position=top buffers',
        },
        -- {
        --   ft = 'Outline',
        --   pinned = true,
        --   open = 'SymbolsOutline',
        -- },
        -- any other neo-tree windows
        'neo-tree',
      },
    },
  }
end

return M
