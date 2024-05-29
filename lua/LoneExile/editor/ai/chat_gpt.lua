local M = {}

M.wh_key = {
  wh_mappings = {
    c = {
      g = {
        '<cmd>ChatGPT<CR>',
        'ChatGPT',
        mode = { 'n' },
      },
    },
  },
}

M.setup = function()
  return {
    'jackMort/ChatGPT.nvim',
    cmd = { 'ChatGPT' },
    -- event = 'VeryLazy',
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
