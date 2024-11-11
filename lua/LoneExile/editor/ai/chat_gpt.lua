local M = {}

M.keys = {
  {
    '<leader>c',
    function()
      local status, wk = pcall(require, 'which-key')
      if not status then
        return
      end
      wk.show({ global = false })
    end,
    desc = 'Copilot',
    mode = 'n',
  },
  {
    '<leader>cg',
    '<cmd>ChatGPT<CR>',
    desc = 'ChatGPT',
    mode = 'n',
  },
}

M.setup = function()
  return {
    'jackMort/ChatGPT.nvim',
    cmd = { 'ChatGPT' },
    -- event = 'VeryLazy',
    keys = M.keys,
    config = function()
      require('chatgpt').setup()
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'folke/trouble.nvim',
      'nvim-telescope/telescope.nvim',
    },
  }
end

return M
