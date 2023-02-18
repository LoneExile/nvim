local M = {}

M.setup = function()
  return {
    'ThePrimeagen/git-worktree.nvim',
    enabled = false,
    lazy = true,
    cmd = 'StartupTime',
    config = function()
      local status_ok, worktree = pcall(require, 'git-worktree')
      if status_ok then
        worktree.setup()
      end
    end,
  }
end

return M
