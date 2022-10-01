local M = {}

local status_ok, whichkey = pcall(require, 'which-key')
if not status_ok then
  return
end

-- https://github.com/akinsho/toggleterm.nvim#custom-terminal-usage
local terminal = require('user.editor.coding.toggleterm').terminal

terminal.execs = {
  { 'lazygit', '<leader>gg', 'LazyGit', 'float' },
  { 'lazygit', '<leader>tg', 'LazyGit', 'float' },
}

local linux = {
  {
    'nnn -er',
    '<leader>tn',
    'nnn',
    'float',
  },
  {
    'btop',
    '<leader>tt',
    'btop',
    'float',
  },
  {
    'bash ' .. vim.fn.stdpath('config') .. '/scripts/cht/cht.sh',
    '<leader>tc',
    'cheet sheet',
    'float',
  },
}

local CURRENTOS = require('user.utils.requirements').CURRENTOS
if CURRENTOS == 'Linux' then
  for _, v in ipairs(linux) do
    table.insert(terminal.execs, v)
  end
end

function M.setup()
  local conf = {
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = true, --* adds help for operators like d, y, ...
        motions = true, --* adds help for motions
        text_objects = true, --* help for text objects triggered after entering an operator
        windows = true, --* default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
      spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
    },
    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = '➜', -- symbol used between a key and it's label
      group = '+', -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = '<c-d>', -- binding to scroll down inside the popup
      scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
      border = 'single', -- none, single, double, shadow
      position = 'bottom', -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 20 }, -- min and max height of the columns
      width = { min = 20, max = 30 }, -- min and max width of the columns
      spacing = 2, -- spacing between columns
      align = 'left', -- align columns left, center or right
    },
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    show_help = false, -- show help message on the command line when the popup is visible
    triggers = 'auto', -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { 'j', 'k' },
      v = { 'j', 'k' },
    },
    disable = {
      -- buftypes = { '*' },
      -- filetypes = { '*' },
    },
  }

  local opts = {
    mode = 'n', -- Normal mode
    prefix = '<leader>',
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  local vopts = {
    mode = 'v', -- VISUAL mode
    prefix = '<leader>',
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  local m_opts = {
    mode = 'n', -- NORMAL mode
    prefix = 'm',
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  local m_mappings = {
    m = { '<cmd>lua require("harpoon.mark").add_file()<cr>', 'Harpoon' },
    ['j'] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', 'Harpoon Next' },
    ['k'] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', 'Harpoon Prev' },
    s = { '<cmd>Telescope harpoon marks<cr>', 'Search Files' },
    [';'] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', 'Harpoon UI' },
  }

  local mappings = {
    ['e'] = {
      '<cmd>Neotree action=focus source=filesystem position=right toggle=true<CR>',
      -- function()
      -- 	vim.cmd("Neotree position=float toggle=true")
      -- end,
      'Explorer',
    },
    [';'] = {
      '<cmd>Alpha<CR>',
      -- function()
      -- 	if ft ~= "neo-tree" then
      -- 		vim.cmd("Alpha")
      -- 	end
      -- end,
      'Dashboard',
    },
    ['w'] = { '<cmd>SaveNFormat<CR>', 'Save' },
    ['q'] = { "<cmd>lua require('user.utils.quit').smart_quit()<CR>", 'Quit' },
    ['/'] = {
      "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
      'Comment',
    },
    ['c'] = {
      require('user.utils.bufKill'),
      'Close Buffer',
    },
    ['f'] = {
      require('telescope.builtin').find_files,
      'Find File',
    },
    ['H'] = {
      '<cmd>nohlsearch<CR>',
      'No Highlight',
    },
    t = { name = 'terminal' },
    -- b = {
    --   name = 'Buffers',
    --   x = {
    --     "<cmd>echo expand('%:p')<cr>",
    --     'Path',
    --   },
    --   j = {
    --     '<cmd>BufferLinePick<cr>',
    --     'Jump',
    --   },
    --   s = {
    --     '<cmd>Telescope buffers<cr>',
    --     'find',
    --   },
    --   p = {
    --     '<cmd>BufferLineCyclePrev<cr>',
    --     'Previous',
    --   },
    --   -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" },
    --   e = {
    --     '<cmd>BufferLinePickClose<cr>',
    --     'Pick which buffer to close',
    --   },
    --   h = {
    --     '<cmd>BufferLineCloseLeft<cr>',
    --     'Close all to the left',
    --   },
    --   l = {
    --     '<cmd>BufferLineCloseRight<cr>',
    --     'Close all to the right',
    --   },
    --   D = {
    --     '<cmd>BufferLineSortByDirectory<cr>',
    --     'Sort by directory',
    --   },
    --   L = {
    --     '<cmd>BufferLineSortByExtension<cr>',
    --     'Sort by language',
    --   },
    -- },
    p = {
      name = 'Packer',
      c = {
        '<cmd>PackerCompile<cr>',
        'Compile',
      },
      i = {
        '<cmd>PackerInstall<cr>',
        'Install',
      },
      s = { '<cmd>PackerSync<cr>', 'Sync' },
      S = {
        '<cmd>PackerStatus<cr>',
        'Status',
      },
      u = {
        '<cmd>PackerUpdate<cr>',
        'Update',
      },
    },
    -- h = {
    --   name = "Harpoon",
    --   h = {
    --     "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
    --     "Harpoon",
    --   },
    --   s = {
    --     "<cmd>lua require('harpoon.mark').add_file()<cr>",
    --     "Add File",
    --   },
    --   a = {
    --     "<cmd>OpenHarpoonAll<cr>",
    --     "Open all",
    --   },
    --   k = {
    --     "<cmd>lua require('harpoon.ui').nav_prev()<cr>",
    --     "Previous",
    --   },
    --   j = { "<cmd>lua require('harpoon.ui').nav_next() <cr>", "Next" },
    -- },
    g = {
      name = 'Git',
      S = { '<cmd>lua require "gitsigns".stage_buffer()<cr>', 'Stage Buffer' },
      j = {
        "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
        'Next Hunk',
      },
      k = {
        "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
        'Prev Hunk',
      },
      l = {
        "<cmd>lua require 'gitsigns'.blame_line()<cr>",
        'Blame',
      },
      p = {
        "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
        'Preview Hunk',
      },
      r = {
        "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
        'Reset Hunk',
      },
      R = {
        "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
        'Reset Buffer',
      },
      s = {
        "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
        'Stage Hunk',
      },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        'Undo Stage Hunk',
      },
      f = {
        '<cmd>Telescope git_status<cr>',
        'Open changed file',
      },
      b = {
        '<cmd>Telescope git_branches<cr>',
        'Checkout branch',
      },
      c = {
        '<cmd>Telescope git_commits<cr>',
        'Checkout commit',
      },
      C = {
        '<cmd>Telescope git_bcommits<cr>',
        'Checkout commit(for current file)',
      },
      w = {
        name = 'Worktree',
        a = { "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", 'Add' },
        c = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", 'Checkout' },
      },
      d = {
        -- "<cmd>Gitsigns diffthis HEAD<cr>",
        name = 'Git Diff',
        d = {
          '<cmd>DiffviewOpen<cr>',
          'Git Diff',
        },
        c = {
          '<cmd>DiffviewClose<cr>',
          'Diff Close',
        },
        f = {
          '<cmd>DiffviewToggleFiles<cr>',
          'Diff Toggle Files',
        },
        r = {
          '<cmd>DiffviewRefresh<cr>',
          'Diff Refresh',
        },
        h = {
          '<cmd>DiffviewFileHistory %<cr>',
          'History Current',
        },
        H = {
          '<cmd>DiffviewFileHistory<cr>',
          'Diff File History',
        },
      },
    },
    l = {
      name = 'LSP',
      d = { '<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>', 'Buffer Diagnostics' },
      w = { '<cmd>Telescope diagnostics<cr>', 'Diagnostics' },
      r = {
        '<cmd>Lspsaga lsp_finder<cr>',
        'References',
      },
      o = {
        '<cmd>LSoutlineToggle<cr>',
        'Outline',
      },
      f = {
        -- require("user.utils.format").format,
        '<cmd>FormatCurrentBuf<CR>',
        'Format',
      },
      R = {
        '<cmd>Lspsaga rename<CR>',
        'Rename',
      },
      a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
      q = { vim.diagnostic.setloclist, 'Quickfix' },
      i = { '<cmd>LspInfo<cr>', 'Info' },
      I = { '<cmd>Mason<cr>', 'Mason Info' },
      s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
      S = {
        '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
        'Workspace Symbols',
      },
      e = { '<cmd>Telescope quickfix<cr>', 'Telescope Quickfix' },
    },
    s = {
      name = 'Search',
      b = {
        '<cmd>Telescope buffers<cr>',
        'find',
      },
      g = {
        '<cmd>Telescope git_status<cr>',
        'Open changed file',
      },

      n = {
        "<cmd>lua require('telescope').extensions.notify.notify(require('telescope.themes').get_dropdown({}))<cr>",
        'Notifications',
      },
      s = {
        "<cmd>lua require('spectre').open_file_search()<CR>",
        'Search/Replace Buf',
      },
      S = {
        "<cmd>lua require('spectre').open()<CR>",
        'Search/Replace Global',
      },
      -- b = {
      -- 	"<cmd>Telescope git_branches<cr>",
      -- 	"Checkout branch",
      -- },
      -- b = { '<cmd>Neotree action=focus source=buffers position=right toggle=true<CR>', 'Buffer Show' },
      -- g = { "<cmd>Neotree action=focus source=git_status position=right toggle=true<CR>", "Git" },
      c = {
        '<cmd>Telescope colorscheme<cr>',
        'Colorscheme',
      },
      f = {
        '<cmd>Telescope find_files<cr>',
        'Find File',
      },
      h = {
        '<cmd>Telescope help_tags<cr>',
        'Find Help',
      },
      H = {
        '<cmd>Telescope highlights<cr>',
        'Find highlight groups',
      },
      M = {
        '<cmd>Telescope man_pages<cr>',
        'Man Pages',
      },
      r = {
        '<cmd>Telescope oldfiles<cr>',
        'Open Recent File',
      },
      R = {
        '<cmd>Telescope registers<cr>',
        'Registers',
      },
      t = {
        '<cmd>Telescope live_grep<cr>',
        'Text',
      },
      T = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", 'Text (string)' },
      k = {
        '<cmd>Telescope keymaps<cr>',
        'Keymaps',
      },
      C = {
        '<cmd>Telescope commands<cr>',
        'Commands',
      },
      p = {
        "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
        'Colorscheme with Preview',
      },
    },
    N = {
      name = 'neovim',
      s = { '<cmd>StartupTime<cr>', 'Startup Time' },
      h = { '<cmd>checkhealth<cr>', 'Check Health' },
      c = { '<cmd>LuaCacheClear<cr>', 'Clear Cache' },
    },
    u = {
      name = '+Utility',
      z = { '<cmd>ZenMode<cr>', 'Zen' },
      h = {
        name = 'highlight',
        h = {
          '<cmd>IlluminateToggle<CR>',
          'Word',
        },
        p = { '<cmd>Twilight<cr>', 'Paragraph' },
        a = { '<cmd>lua require("hlargs").toggle()<cr>', 'Arguments' },
      },
      t = { '<cmd>TodoTelescope<cr>', 'TODO' },
      m = {
        name = '+Mark',
        a = { '<cmd>MarksToggleSigns<cr>', 'Toggle' },
        b = { '<cmd>MarksListBuf<cr>', 'List' },
        g = { '<cmd>MarksListGlobal<cr>', 'List All' },
        d = { "<cmd>lua require'marks'.delete_buf()<cr>", 'Delete buf' },
        j = { '<Plug>(Marks-next)', 'Next' },
        k = { '<Plug>(Marks-prev)', 'Prev' },
      },
      n = {
        name = '+Neotree',
        b = { '<cmd>Neotree action=focus source=buffers position=right toggle=true<CR>', 'Buffer' },
        g = { '<cmd>Neotree action=focus source=git_status position=right toggle=true<CR>', 'Git' },
        r = { '<cmd>Neotree action=focus source=filesystem position=right toggle=true<CR>', 'Files' },
      },
      -- s = {
      --   name = '+Session',
      --   l = { '<cmd>SessionManager load_last_session<cr>', 'Load last session' },
      --   s = { '<cmd>SessionManager save_current_session<cr>', 'Save session' },
      --   d = { '<cmd>SessionManager delete_session<cr>', 'Delete session' },
      --   L = { '<cmd>SessionManager load_session<cr>', 'Load session' },
      --   c = { '<cmd>SessionManager load_current_dir_session<cr>', 'Load current dir' },
      -- },
      c = {
        name = '+Color picker',
        p = {
          '<cmd>Colortils picker<cr>',
          'picker',
        },
        l = {
          '<cmd>Colortils lighten<cr>',
          'lighten',
        },
        d = {
          '<cmd>Colortils darken<cr>',
          'darken',
        },
        s = {
          '<cmd>Colortils greyscale<cr>',
          'greyscale',
        },
        g = {
          '<cmd>Colortils gradient<cr>',
          'gradient',
        },
        L = { '<cmd>Colortils css list<cr>', 'List' },
      },
    },
    x = {
      name = '+Execute',
      p = { "<cmd>lua require('swenv.api').pick_venv()<cr>", 'Pyenv' },
      r = {
        name = 'Refactor',
        b = { "<Cmd>lua require('refactoring').refactor('Extract Block')<cr>", 'Extract Block' },
        B = {
          "<Cmd>lua require('refactoring').refactor('Extract Function To File')<cr>",
          'Extract Function To File',
        },
        i = { "<Cmd>lua require('refactoring').refactor('Inline Variable')<cr>", 'Inline Local' },
        s = { "<Cmd>lua require('refactoring').select_refactor()<CR>", 'Select Refactor' },
      },
      c = {
        name = '+Code',
        c = {
          name = '+Codi',
          c = {
            '<cmd>Codi!!<cr>',
            'Codi Toggle',
          },
          e = {
            '<cmd>CodiExpand<cr>',
            'Expand',
          },
          s = {
            '<cmd>:CodiSelect<cr>',
            'Select',
          },
        },
        s = {
          name = '+Sniprun',
          c = {
            "<cmd>lua require'sniprun'.run()<cr>",
            'Run',
          },
          r = {
            "<cmd>lua require'sniprun'.reset()<cr>",
            'Reset',
          },
          s = {
            "<cmd>lua require'sniprun.display'.close_all()<cr>",
            'Stop',
          },
          l = {
            "<cmd>lua require'sniprun.live_mode'.toggle()<cr>",
            'Live',
          },
          i = {
            "<cmd>lua require'sniprun'.info()<cr>",
            'Info',
          },
          m = {
            "<cmd>lua require'sniprun'.clear_repl()<cr>",
            'Memory Clear',
          },
        },
        l = {
          name = '+Lab',
          r = { '<cmd>Lab code run<cr>', 'Run' },
          s = { '<cmd>Lab code stop<cr>', 'Stop' },
          p = { '<cmd>Lab code panel<cr>', 'Panel' },
          c = { '<cmd>Lab code config<cr>', 'Config' },
        },
      },
    },
    d = {
      name = 'Debug',
      U = {
        name = 'UI',
        T = { "lua require('dapui').toggle()<cr>", 'Toggle Dap UI' },
        e = { "lua require('dapui').eval()<cr>", 'Evaluate Expression' },
        f = {
          "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
          'UI Scopes',
        },
      },
      v = { '<cmd>DapVirtualTextToggle<cr>', 'Toggle virtual text' },
      T = { '<cmd>DapTerminate<cr>', 'Terminate' },
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", 'Toggle Breakpoint' },
      b = { "<cmd>lua require'dap'.step_back()<cr>", 'Step Back' },
      B = {
        "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
        'Breakpoint condition',
      },
      l = {
        "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
        'Log point',
      },
      L = { "<Cmd>lua require'dap'.run_last()<CR>", 'Run last' },
      c = { "<cmd>lua require'dap'.continue()<cr>", 'Continue' },
      C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", 'Run To Cursor' },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", 'Disconnect' },
      g = { "<cmd>lua require'dap'.session()<cr>", 'Get Session' },
      i = { "<cmd>lua require'dap'.step_into()<cr>", 'Step Into' },
      o = { "<cmd>lua require'dap'.step_over()<cr>", 'Step Over' },
      u = { "<cmd>lua require'dap'.step_out()<cr>", 'Step Out' },
      p = { "<cmd>lua require'dap'.pause()<cr>", 'Pause' },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", 'Toggle Repl' },
      s = { "<cmd>lua require'dap'.continue()<cr>", 'Start' },
      q = { "<cmd>lua require'dap'.close()<cr>", 'Quit' },
    },
  }

  local vmappings = {
    x = {
      name = '+Code',
      s = { name = 'SnipRun', c = { "<Esc><cmd>lua require'sniprun'.run('v')<cr>", 'Run' } },
      r = {
        name = 'refactor',
        f = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>", 'Extract Function' },
        F = {
          "<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
          'Extract Function To File',
        },
        v = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>", 'Extract Variable' },
        V = {
          "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable To File')<CR>",
          'Extract Variable To File',
        },
        s = { "<Cmd>lua require('refactoring').select_refactor()<CR>", 'Select Refactor' },
      },
    },
    ['/'] = { '<Plug>(comment_toggle_linewise_visual)', 'Comment toggle linewise (visual)' },
  }

  whichkey.setup(conf)

  whichkey.register(mappings, opts)
  whichkey.register(vmappings, vopts)
  whichkey.register(m_mappings, m_opts)
end

return M.setup()
