local M = {}

M.wh_key = {
  wh_mappings = {
    l = {
      name = 'LSP',
      o = { '<cmd>Lspsaga outline<cr>', 'Outline', mode = { 'n' } },
    },
  },
  wh_g_mappings = {
    ['d'] = { '<cmd>Lspsaga peek_definition<CR>', 'Goto Definition', mode = { 'n' } },
    ['p'] = { '<cmd>Lspsaga peek_type_definition<CR>', 'Peek type definition', mode = { 'n' } },
    ['s'] = { vim.lsp.buf.signature_help, 'show signature help', mode = { 'n' } },
    ['r'] = { '<cmd>Lspsaga finder<CR>', 'Goto references', mode = { 'n' } },
    ['R'] = { '<cmd>Lspsaga rename<CR>', 'rename', mode = { 'n' } },
    ['q'] = { '<cmd>Lspsaga code_action<CR>', 'Code action', mode = { 'n', 'v' } },
    ['j'] = { '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next diagnostic', mode = { 'n' } },
    ['k'] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Prev diagnostic', mode = { 'n' } },
    ['o'] = { '<cmd>Lspsaga goto_definition<cr>', 'Goto Implementation', mode = { 'n' } },
    ['l'] = { '<cmd>Lspsaga show_line_diagnostics<cr>', 'Show line diagnostics', mode = { 'n' } },
    ['D'] = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Goto declaration', mode = { 'n' } },
    ['I'] = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Goto Implementation', mode = { 'n' } },
  },
}

M.setup = function(_, _)
  return {
    'glepnir/lspsaga.nvim',
    -- commit = '06a131f8ed5eab8c8aaa9b20586ceca6be707b7a',
    event = { 'BufRead' },
    dependencies = { 'neovim/nvim-lspconfig' },
    keys = {
      { 'K', '<cmd>Lspsaga hover_doc<CR>', desc = 'Hover' },
    },
    config = function()
      local status_ok, lspsagaM = pcall(require, 'lspsaga')
      if not status_ok then
        return
      end

      ------------------------------------------------------------------------------------------
      local config = {
        preview = {
          lines_above = 0,
          lines_below = 10,
        },
        scroll_preview = {
          scroll_down = '<C-f>',
          scroll_up = '<C-b>',
        },
        request_timeout = 20000,
        finder = {
          edit = { 'o', '<CR>' },
          vsplit = 's',
          split = 'i',
          tabe = 't',
          quit = { 'q', '<ESC>' },
        },
        -- definition = {
        --   edit = '<space>oo',
        --   vsplit = '<space>ov',
        --   split = '<space>os',
        --   tabe = '<space>ot',
        --   quit = 'q',
        --   close = '<Esc>',
        -- },
        code_action = {
          extend_gitsigns = true,
          num_shortcut = true,
          keys = {
            quit = 'q',
            exec = '<CR>',
          },
        },
        lightbulb = {
          enable = false,
          enable_in_insert = false,
          sign = true,
          sign_priority = 40,
          virtual_text = true,
        },
        diagnostic = {
          twice_into = false,
          show_code_action = true,
          show_source = true,
          keys = {
            exec_action = 'o',
            quit = 'q',
          },
        },
        rename = {
          quit = '<C-c>',
          exec = '<CR>',
          in_select = true,
        },
        outline = {
          win_position = 'right',
          win_with = '',
          win_width = 30,
          show_detail = true,
          auto_preview = false,
          auto_refresh = true,
          auto_close = true,
          custom_sort = nil,
          keys = {
            jump = 'o',
            expand_collapse = 'u',
            quit = 'q',
          },
        },
        callhierarchy = {
          show_detail = false,
          keys = {
            edit = 'e',
            vsplit = 's',
            split = 'i',
            tabe = 't',
            jump = 'o',
            quit = 'q',
            expand_collapse = 'u',
          },
        },
        symbol_in_winbar = {
          enable = false,
          separator = ' ',
          hide_keyword = true,
          show_file = false,
          folder_level = 2,
        },
        ui = {
          theme = 'round',
          -- border type can be single,double,rounded,solid,shadow.
          border = 'rounded',
          winblend = 0,
          expand = '',
          collapse = '',
          preview = ' ',
          code_action = '💡',
          diagnostic = '🐞',
          incoming = ' ',
          outgoing = ' ',
          colors = {
            --float window normal background color
            normal_bg = 'none',
            --title background color
            title_bg = '#afd700',
            red = '#e95678',
            magenta = '#b33076',
            orange = '#FF8700',
            yellow = '#f7bb3b',
            green = '#afd700',
            cyan = '',
            blue = '#61afef',
            purple = '#CBA6F7',
            white = '#d1d4cf',
            black = '#1c1c19',
          },
          kind = {},
        },
      }
      lspsagaM.setup(config)
    end,
  }
end

return M
