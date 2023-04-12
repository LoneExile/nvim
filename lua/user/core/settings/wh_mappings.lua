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
      s = { '<cmd>StartupTime<cr>', 'Startup Time', mode = { 'n' } },
      h = { '<cmd>checkhealth<cr>', 'Check Health', mode = { 'n' } },
      c = { '<cmd>LuaCacheClear<cr>', 'Clear Cache', mode = { 'n' } },
    },
    u = {
      name = '+Utility',
      w = {
        name = '+Windows',
        m = { '<cmd>WindowsMaximize!<cr>', 'Maximize', mode = { 'n' } },
        e = { '<cmd>WindowsEqualize<cr>', 'Equal', mode = { 'n' } },
        t = { '<cmd>WindowsToggleAutowidth<cr>', 'Toggle', mode = { 'n' } },
      },
      d = {
        name = 'Diff Buf',
        a = { '<cmd>windo diffthis<cr>', 'Diff All', mode = { 'n' } },
        c = { '<cmd>diffoff!<cr>', 'Diff Off', mode = { 'n' } },
        t = { '<cmd>diffthis<cr>', 'Diff This', mode = { 'n' } },
      },
      z = { '<cmd>ZenMode<cr>', 'Zen', mode = { 'n' } },
      h = {
        name = 'highlight',
        h = {
          '<cmd>IlluminateToggle<CR>',
          'Word',
          mode = { 'n' },
        },
        p = { '<cmd>Twilight<cr>', 'Paragraph', mode = { 'n' } },
        a = { '<cmd>lua require("hlargs").toggle()<cr>', 'Arguments', mode = { 'n' } },
      },
      t = { '<cmd>TodoTelescope<cr>', 'TODO', mode = { 'n' } },
      m = {
        name = '+Mark',
        a = { '<cmd>MarksToggleSigns<cr>', 'Toggle', mode = { 'n' } },
        b = { '<cmd>MarksListBuf<cr>', 'List', mode = { 'n' } },
        g = { '<cmd>MarksListGlobal<cr>', 'List All', mode = { 'n' } },
        d = { "<cmd>lua require'marks'.delete_buf()<cr>", 'Delete buf', mode = { 'n' } },
        -- ':execute "normal \\<Plug>(Marks-next)"<CR>', -- e.g. for mapping
        j = { '<Plug>(Marks-next)', 'Next', mode = { 'n' } },
        k = { '<Plug>(Marks-prev)', 'Prev', mode = { 'n' } },
      },
      n = {
        name = '+Neotree',
        b = {
          '<cmd>Neotree action=focus source=buffers position=right toggle=true<CR>',
          'Buffer',
          mode = { 'n' },
        },
        g = {
          '<cmd>Neotree action=focus source=git_status position=right toggle=true<CR>',
          'Git',
          mode = { 'n' },
        },
        r = {
          '<cmd>Neotree action=focus source=filesystem position=right toggle=true<CR>',
          'Files',
          mode = { 'n' },
        },
      },
      c = {
        name = '+Color picker',
        p = {
          '<cmd>Colortils picker<cr>',
          'picker',
          mode = { 'n' },
        },
        l = {
          '<cmd>Colortils lighten<cr>',
          'lighten',
          mode = { 'n' },
        },
        d = {
          '<cmd>Colortils darken<cr>',
          'darken',
          mode = { 'n' },
        },
        s = {
          '<cmd>Colortils greyscale<cr>',
          'greyscale',
          mode = { 'n' },
        },
        g = {
          '<cmd>Colortils gradient<cr>',
          'gradient',
          mode = { 'n' },
        },
        L = { '<cmd>Colortils css list<cr>', 'List', mode = { 'n' } },
      },
    },
    x = {
      name = '+Execute',
      a = {
        name = '+AI',
        c = { '<cmd>ChatGPT<cr>', 'ChatGPT', mode = { 'n' } },
        a = { '<cmd>ChatGPTActAs<cr>', 'ActAs', mode = { 'n' } },
        i = { '<cmd>ChatGPTEditWithInstructions<cr>', 'Instructions', mode = { 'n', 'v' } },
      },
      b = {
        name = '+Browser',
        s = { '<cmd>Browserstop<cr>', 'Stop', mode = { 'n' } },
        o = { '<cmd>BrowserOpen<cr>', 'Open', mode = { 'n' } },
        r = { '<cmd>BrowserRestart<cr>', 'Restart', mode = { 'n' } },
      },
      p = { "<cmd>lua require('swenv.api').pick_venv()<cr>", 'Pyenv', mode = { 'n' } },
      r = {
        name = 'Refactor',
        b = {
          "<Cmd>lua require('refactoring').refactor('Extract Block')<cr>",
          'Extract Block',
          mode = { 'n' },
        },
        B = {
          "<Cmd>lua require('refactoring').refactor('Extract Function To File')<cr>",
          'Extract Function To File',
          mode = { 'n' },
        },
        i = {
          "<Cmd>lua require('refactoring').refactor('Inline Variable')<cr>",
          'Inline Local',
          mode = { 'n' },
        },
        f = {
          "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>",
          'Extract Function',
          mode = { 'v' },
        },
        F = {
          "<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
          'Extract Function To File',
          mode = { 'v' },
        },
        v = {
          "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>",
          'Extract Variable',
          mode = { 'v' },
        },
        V = {
          "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable To File')<CR>",
          'Extract Variable To File',
          mode = { 'v' },
        },
        s = {
          "<Cmd>lua require('refactoring').select_refactor()<CR>",
          'Select Refactor',
          mode = { 'n', 'v' },
        },
      },
      c = {
        name = '+Code',
        c = {
          name = '+Codi',
          c = {
            '<cmd>Codi!!<cr>',
            'Codi Toggle',
            mode = { 'n' },
          },
          e = {
            '<cmd>CodiExpand<cr>',
            'Expand',
            mode = { 'n' },
          },
          s = {
            '<cmd>:CodiSelect<cr>',
            'Select',
            mode = { 'n' },
          },
        },
        s = {
          name = '+Sniprun',
          c = {
            "<cmd>lua require'sniprun'.run()<cr>",
            'Run',
            mode = { 'n', 'v' },
          },
          r = {
            "<cmd>lua require'sniprun'.reset()<cr>",
            'Reset',
            mode = { 'n' },
          },
          s = {
            "<cmd>lua require'sniprun.display'.close_all()<cr>",
            'Stop',
            mode = { 'n' },
          },
          l = {
            "<cmd>lua require'sniprun.live_mode'.toggle()<cr>",
            'Live',
            mode = { 'n' },
          },
          i = {
            "<cmd>lua require'sniprun'.info()<cr>",
            'Info',
            mode = { 'n' },
          },
          m = {
            "<cmd>lua require'sniprun'.clear_repl()<cr>",
            'Memory Clear',
            mode = { 'n' },
          },
        },
        l = {
          name = '+Lab',
          r = { '<cmd>Lab code run<cr>', 'Run', mode = { 'n' } },
          s = { '<cmd>Lab code stop<cr>', 'Stop', mode = { 'n' } },
          p = { '<cmd>Lab code panel<cr>', 'Panel', mode = { 'n' } },
          c = { '<cmd>Lab code config<cr>', 'Config', mode = { 'n' } },
        },
      },
    },
    d = {
      name = 'Debug',
      U = {
        name = 'UI',
        T = { "lua require('dapui').toggle()<cr>", 'Toggle Dap UI', mode = { 'n' } },
        e = { "lua require('dapui').eval()<cr>", 'Evaluate Expression', mode = { 'n' } },
        f = {
          "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
          'UI Scopes',
          mode = { 'n' },
        },
      },
      v = { '<cmd>DapVirtualTextToggle<cr>', 'Toggle virtual text', mode = { 'n' } },
      T = { '<cmd>DapTerminate<cr>', 'Terminate', mode = { 'n' } },
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", 'Toggle Breakpoint', mode = { 'n' } },
      b = { "<cmd>lua require'dap'.step_back()<cr>", 'Step Back', mode = { 'n' } },
      B = {
        "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
        'Breakpoint condition',
        mode = { 'n' },
      },
      l = {
        "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
        'Log point',
        mode = { 'n' },
      },
      L = { "<Cmd>lua require'dap'.run_last()<CR>", 'Run last', mode = { 'n' } },
      c = { "<cmd>lua require'dap'.continue()<cr>", 'Continue', mode = { 'n' } },
      C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", 'Run To Cursor', mode = { 'n' } },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", 'Disconnect', mode = { 'n' } },
      g = { "<cmd>lua require'dap'.session()<cr>", 'Get Session', mode = { 'n' } },
      i = { "<cmd>lua require'dap'.step_into()<cr>", 'Step Into', mode = { 'n' } },
      o = { "<cmd>lua require'dap'.step_over()<cr>", 'Step Over', mode = { 'n' } },
      u = { "<cmd>lua require'dap'.step_out()<cr>", 'Step Out', mode = { 'n' } },
      p = { "<cmd>lua require'dap'.pause()<cr>", 'Pause', mode = { 'n' } },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", 'Toggle Repl', mode = { 'n' } },
      s = { "<cmd>lua require'dap'.continue()<cr>", 'Start', mode = { 'n' } },
      q = { "<cmd>lua require'dap'.close()<cr>", 'Quit', mode = { 'n' } },
    },
  },
  m_mappings = {},
}
