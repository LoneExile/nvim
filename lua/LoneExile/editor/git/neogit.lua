local M = {}

M.keys = {
  {
    '<leader>g',
    '',
    desc = 'Git',
    mode = 'n',
  },
  {
    '<leader>go',
    '<cmd>Neogit<cr>',
    desc = 'Neogit',
    mode = 'n',
  },
  -- {
  --   '<leader>gc',
  --   '<cmd>Neogit commit<cr>',
  --   desc = 'Neogit Commit',
  --   mode = 'n',
  -- },
}

M.setup = function()
  return {
    'NeogitOrg/neogit',
    lazy = true,
    cmd = 'Neogit',
    keys = M.keys,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'dlyongemallo/diffview.nvim', -- for diff integration (matches existing fork)
      "m00qek/baleia.nvim", -- For a custom log pager
    },
    config = function()
      local status_ok, neogit = pcall(require, 'neogit')
      if not status_ok then
        return
      end

      neogit.setup({
        -- Integrations (auto-detected, but explicit is clearer)
        integrations = {
          diffview = true,
          -- fzf_lua and snacks are present in this config and will be auto-detected
        },

        -- Keep UI consistent with other git tools in this config
        kind = 'tab',
        commit_editor = {
          kind = 'tab',
        },
        commit_view = {
          kind = 'vsplit',
        },
      })
    end,
  }
end

return M
