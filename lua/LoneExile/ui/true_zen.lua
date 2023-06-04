local M = {}

M.wh_key = {
  wh_mappings = {
    z = {
      name = '+Zen',
      -- n = { '<cmd>TZNarrow<cr>', 'Narrow', mode = { 'n' } },
      n = { "<cmd>'<,'>TZNarrow<cr>", 'Narrow', mode = { 'v' } },
      f = { '<cmd>TZFocus<cr>', 'Focus', mode = { 'n' } },
      m = { '<cmd>TZMinimalist<cr>', 'Minimalist', mode = { 'n' } },
      a = { '<cmd>TZAtaraxis<cr>', 'Ataraxis', mode = { 'n' } },
    },
  },
}

M.setup = function()
  return {
    'Pocco81/true-zen.nvim',
    lazy = true,
    keys = { '<leader>' },
    config = function()
      local status_ok, true_zen = pcall(require, 'true-zen')
      if not status_ok then
        vim.notify('true_zen' .. ' not found!')
        return
      end

      true_zen.setup()
    end,
  }
end

return M
