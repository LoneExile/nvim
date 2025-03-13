local M = {}

M.setup = function()
  return {
    'glacambre/firenvim',

    build = ":call firenvim#install(0)"

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    -- cond = not not vim.g.started_by_firenvim,
    -- build = function()
    --   ---@diagnostic disable-next-line: assign-type-mismatch
    --   require('lazy').load({ plugins = 'firenvim', wait = true })
    --   vim.fn['firenvim#install'](0)
    -- end,
  }
end

return M
