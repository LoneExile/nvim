local M = {}
M.enabled = false

M.wh_key = {
  enabled = M.enabled,
  wh_mappings = {
    ['g'] = {
      name = 'Git',
      w = {
        name = 'Worktree',
        a = {
          "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
          'Add',
          mode = { 'n' },
        },
        c = {
          "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
          'Checkout',
          mode = { 'n' },
        },
      },
    },
  },
}

M.setup = function()
  return {
    'ThePrimeagen/git-worktree.nvim',
    enabled = M.enabled,
    lazy = true,
    config = function()
      local status_ok, worktree = pcall(require, 'git-worktree')
      if status_ok then
        worktree.setup()

        local status, telescope = pcall(require, 'telescope')
        if status then
          telescope.load_extension('git_worktree')
        end
      end
    end,
  }
end

return M
