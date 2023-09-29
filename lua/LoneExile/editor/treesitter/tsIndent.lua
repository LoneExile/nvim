local M = {}

M.setup = function()
  return {
    'lukas-reineke/indent-blankline.nvim',
    commit = '9637670896b68805430e2f72cf5d16be5b97a22a',
    event = 'BufRead',
    config = function()
      local status_ok_code, indent_blankline = pcall(require, 'indent_blankline')
      if not status_ok_code then
        return
      end

      -- :help indent_blankline.txt

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
      -- vim.opt.listchars:append("space:⋅")

      local opts = {
        char_highlight_list = {},
        -- char = "▏",
        filetype_exclude = {
          'alpha',
          'help',
          'terminal',
          'dashboard',
          'lspinfo',
          'lsp-installer',
          'mason',
          'neo-tree',
          'packer',
          'noice',
        },
        buftype_exclude = { 'terminal' },
        bufname_exclude = { 'config.lua' },
        show_trailing_blankline_indent = false,
        show_first_indent_level = true,
        use_treesitter = true,
        show_end_of_line = true,
        space_char_blankline = ' ',
        show_current_context = true,
        show_current_context_start = false, -- underline
      }

      indent_blankline.setup(opts)
    end,
  }
end

return M
