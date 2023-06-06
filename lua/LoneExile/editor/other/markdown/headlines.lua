local M = {}

M.setup = function()
  return {
    'lukas-reineke/headlines.nvim',
    ft = { 'markdown' },
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      vim.cmd([[highlight Headline1 guibg=#1e2718]])
      vim.cmd([[highlight Headline2 guibg=#21262d]])
      vim.cmd([[highlight CodeBlock guibg=#1c1c1c]])
      vim.cmd([[highlight Dash guibg=#D19A66 gui=bold]])

      local status_ok, headlines = pcall(require, 'headlines')
      if not status_ok then
        return
      end

      headlines.setup({
        org = {
          headline_highlights = { 'Headline1', 'Headline2' },
        },
      })
    end,
  }
end

return M
