local M = {}

vim.opt.list = true
vim.opt.listchars:append('eol:↴')

M.setup = function()
  return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'BufRead',
    config = function()
      local status_ok_code, indent_blankline = pcall(require, 'ibl')
      if not status_ok_code then
        return
      end

      vim.opt.termguicolors = true
      -- vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
      -- vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
      -- vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
      -- vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
      -- vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
      -- vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])
      -- vim.cmd([[highlight IndentBlanklineContextStart guifg=#C678DD gui=underline]])

      vim.opt.list = true
      vim.opt.listchars:append('eol:↴')

      local opts = {}

      indent_blankline.setup(opts)
    end,
  }
end

return M
