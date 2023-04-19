return {
  mappings = {
    ['w'] = {
      '<cmd>SaveNFormat<CR>',
      'Save',
      mode = { 'n' },
      ft = { only = {}, exclude = { 'alpha', 'neo-tree' } },
    },
    ['q'] = {
      "<cmd>lua require('user.utils.quit').smart_quit()<CR>",
      'Quit',
      mode = { 'n' },
    },
    ['c'] = {
      "<cmd>lua require('user.utils.bufKill').buf_kill()<CR>",
      'Close Buffer',
      mode = { 'n' },
    },
    ['H'] = {
      '<cmd>nohlsearch<CR>',
      'No Highlight',
      mode = { 'n' },
    },
    t = { name = 'Terminal' },
    p = {
      name = 'Plugin',
      c = {
        '<cmd>Lazy clean<cr>',
        'Clean',
        mode = { 'n' },
      },
      s = { '<cmd>Lazy sync<cr>', 'Sync', mode = { 'n' } },
      u = {
        '<cmd>Lazy update<cr>',
        'Update',
        mode = { 'n' },
      },
      l = {
        '<cmd>Lazy<cr>',
        'Lazy',
        mode = { 'n' },
      },
      L = {
        '<cmd>Lazy log<cr>',
        'Log',
        mode = { 'n' },
      },
      r = {
        '<cmd>Lazy resore<cr>',
        'Restore',
        mode = { 'n' },
      },
    },
    l = {
      name = 'LSP',
      f = {
        '<cmd>FormatCurrentBuf<CR>',
        'Format',
        mode = { 'n' },
      },
      d = {
        vim.diagnostic.setloclist,
        'Diagnostics',
        mode = { 'n' },
      },
      D = {
        '<cmd>Telescope diagnostics<CR>',
        'Diagnostics',
        mode = { 'n' },
      },
      r = {
        '<cmd>Telescope lsp_references<cr>',
        'References',
        mode = { 'n' },
      },
      o = {
        '<cmd>Lspsaga outline<cr>',
        'Outline',
        mode = { 'n' },
      },
      l = {
        name = 'LSP',
        r = {
          '<cmd>LspRestart<cr>',
          'Restart',
          mode = { 'n' },
        },
        s = {
          '<cmd>LspStop<cr>',
          'Stop',
          mode = { 'n' },
        },
      },
      i = {
        '<cmd>LspInfo<cr>',
        'LSP Info',
        mode = { 'n' },
      },
      I = {
        '<cmd>Mason<cr>',
        'Mason',
        mode = { 'n' },
      },
      -- s = {
      --   '<cmd>Telescope lsp_document_symbols<cr>',
      --   'Document Symbols',
      --   mode = { 'n' },
      -- },
      -- S = {
      --   '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
      --   'Workspace Symbols',
      --   mode = { 'n' },
      -- },
    },
    N = {
      name = 'Neovim',
      h = { '<cmd>checkhealth<cr>', 'Check Health', mode = { 'n' } },
      c = { '<cmd>LuaCacheClear<cr>', 'Clear Cache', mode = { 'n' } },
    },
    u = {
      name = '+Utility',
      d = {
        name = 'Diff Buf',
        a = { '<cmd>windo diffthis<cr>', 'Diff All', mode = { 'n' } },
        c = { '<cmd>diffoff!<cr>', 'Diff Off', mode = { 'n' } },
        t = { '<cmd>diffthis<cr>', 'Diff This', mode = { 'n' } },
      },
    },
  },
  m_mappings = {},
}
