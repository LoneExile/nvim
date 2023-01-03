local M = {}

local status_ok, whichkey = pcall(require, 'which-key')
if not status_ok then
  return
end

-- https://github.com/akinsho/toggleterm.nvim#custom-terminal-usage
local terminal = require('user.editor.coding.toggleterm').terminal

-- TODO: check is command is available before mapping
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
if CURRENTOS == 'Linux' or CURRENTOS == 'Darwin' then
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

  local mappings_all = {
    ['e'] = {
      '<cmd>Neotree action=focus source=filesystem position=right toggle=true<CR>',
      -- function()
      -- 	vim.cmd("Neotree position=float toggle=true")
      -- end,
      'Explorer',
      mode = { 'n' },
    },
    [';'] = {
      '<cmd>Alpha<CR>',
      -- function()
      -- 	if ft ~= "neo-tree" then
      -- 		vim.cmd("Alpha")
      -- 	end
      -- end,
      'Dashboard',
      mode = { 'n' },
    },
    ['w'] = { '<cmd>SaveNFormat<CR>', 'Save', mode = { 'n' } },
    ['q'] = { "<cmd>lua require('user.utils.quit').smart_quit()<CR>", 'Quit', mode = { 'n' } },
    ['/'] = {
      cmd = {
        n = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
        v = '<Plug>(comment_toggle_linewise_visual)',
      },
      'Comment',
      mode = { 'n', 'v' },
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
    g = {
      name = 'Git',
      S = { '<cmd>lua require "gitsigns".stage_buffer()<cr>', 'Stage Buffer', mode = { 'n' } },
      j = {
        "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
        'Next Hunk',
        mode = { 'n' },
      },
      k = {
        "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
        'Prev Hunk',
        mode = { 'n' },
      },
      l = {
        "<cmd>lua require 'gitsigns'.blame_line()<cr>",
        'Blame',
        mode = { 'n' },
      },
      p = {
        "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
        'Preview Hunk',
        mode = { 'n' },
      },
      r = {
        "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
        'Reset Hunk',
        mode = { 'n' },
      },
      R = {
        "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
        'Reset Buffer',
        mode = { 'n' },
      },
      s = {
        "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
        'Stage Hunk',
        mode = { 'n' },
      },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        'Undo Stage Hunk',
        mode = { 'n' },
      },
      f = {
        '<cmd>Telescope git_status<cr>',
        'Open changed file',
        mode = { 'n' },
      },
      b = {
        '<cmd>Telescope git_branches<cr>',
        'Checkout branch',
        mode = { 'n' },
      },
      c = {
        '<cmd>Telescope git_commits<cr>',
        'Checkout commit',
        mode = { 'n' },
      },
      C = {
        '<cmd>Telescope git_bcommits<cr>',
        'Checkout commit(for current file)',
        mode = { 'n' },
      },
      w = {
        name = 'Worktree',
        a = { "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", 'Add', mode = { 'n' } },
        c = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", 'Checkout', mode = { 'n' } },
      },
      d = {
        -- "<cmd>Gitsigns diffthis HEAD<cr>",
        name = 'Git Diff',
        d = {
          '<cmd>DiffviewOpen<cr>',
          'Git Diff',
          mode = { 'n' },
        },
        c = {
          '<cmd>DiffviewClose<cr>',
          'Diff Close',
          mode = { 'n' },
        },
        f = {
          '<cmd>DiffviewToggleFiles<cr>',
          'Diff Toggle Files',
          mode = { 'n' },
        },
        r = {
          '<cmd>DiffviewRefresh<cr>',
          'Diff Refresh',
          mode = { 'n' },
        },
        h = {
          '<cmd>DiffviewFileHistory %<cr>',
          'History Current',
          mode = { 'n' },
        },
        H = {
          '<cmd>DiffviewFileHistory<cr>',
          'Diff File History',
          mode = { 'n' },
        },
      },
    },
    l = {
      name = 'LSP',
      d = { '<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>', 'Buffer Diagnostics', mode = { 'n' } },
      w = { '<cmd>Telescope diagnostics<cr>', 'Diagnostics', mode = { 'n' } },
      r = {
        '<cmd>Lspsaga lsp_finder<cr>',
        'References',
        mode = { 'n' },
      },
      o = {
        '<cmd>LSoutlineToggle<cr>',
        'Outline',
        mode = { 'n' },
      },
      f = {
        -- require("user.utils.format").format,
        '<cmd>FormatCurrentBuf<CR>',
        'Format',
        mode = { 'n' },
      },
      R = {
        '<cmd>Lspsaga rename<CR>',
        'Rename',
        mode = { 'n' },
      },
      a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action', mode = { 'n' } },
      q = { vim.diagnostic.setloclist, 'Quickfix', mode = { 'n' } },
      i = { '<cmd>LspInfo<cr>', 'Info', mode = { 'n' } },
      I = { '<cmd>Mason<cr>', 'Mason Info', mode = { 'n' } },
      s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols', mode = { 'n' } },
      S = {
        '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
        'Workspace Symbols',
        mode = { 'n' },
      },
      e = { '<cmd>Telescope quickfix<cr>', 'Telescope Quickfix', mode = { 'n' } },
    },
    s = {
      name = 'Search',
      b = {
        '<cmd>Telescope buffers<cr>',
        'find',
        mode = { 'n' },
      },
      g = {
        '<cmd>Telescope git_status<cr>',
        'Open changed file',
        mode = { 'n' },
      },

      n = {
        "<cmd>lua require('telescope').extensions.notify.notify(require('telescope.themes').get_dropdown({initial_mode = 'normal'}))<cr>",
        'Notifications',
        mode = { 'n' },
      },
      s = {
        "<cmd>lua require('spectre').open_file_search()<CR>",
        'Search/Replace Buf',
        mode = { 'n' },
      },
      S = {
        "<cmd>lua require('spectre').open()<CR>",
        'Search/Replace Global',
        mode = { 'n' },
      },
      c = {
        '<cmd>Telescope colorscheme<cr>',
        'Colorscheme',
        mode = { 'n' },
      },
      f = {
        '<cmd>Telescope find_files<cr>',
        'Find File',
        mode = { 'n' },
      },
      h = {
        '<cmd>Telescope help_tags<cr>',
        'Find Help',
        mode = { 'n' },
      },
      H = {
        '<cmd>Telescope highlights<cr>',
        'Find highlight groups',
        mode = { 'n' },
      },
      M = {
        '<cmd>Telescope man_pages<cr>',
        'Man Pages',
        mode = { 'n' },
      },
      r = {
        '<cmd>Telescope oldfiles<cr>',
        'Open Recent File',
        mode = { 'n' },
      },
      R = {
        '<cmd>Telescope registers<cr>',
        'Registers',
        mode = { 'n' },
      },
      t = {
        '<cmd>Telescope live_grep<cr>',
        'Text',
        mode = { 'n' },
      },
      T = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", 'Text (string)', mode = { 'n' } },
      k = {
        '<cmd>Telescope keymaps<cr>',
        'Keymaps',
        mode = { 'n' },
      },
      C = {
        '<cmd>Telescope commands<cr>',
        'Commands',
        mode = { 'n' },
      },
      p = {
        "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
        'Colorscheme with Preview',
        mode = { 'n' },
      },
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
        j = { '<Plug>(Marks-next)', 'Next', mode = { 'n' } },
        k = { '<Plug>(Marks-prev)', 'Prev', mode = { 'n' } },
      },
      n = {
        name = '+Neotree',
        b = { '<cmd>Neotree action=focus source=buffers position=right toggle=true<CR>', 'Buffer', mode = { 'n' } },
        g = { '<cmd>Neotree action=focus source=git_status position=right toggle=true<CR>', 'Git', mode = { 'n' } },
        r = { '<cmd>Neotree action=focus source=filesystem position=right toggle=true<CR>', 'Files', mode = { 'n' } },
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
        b = { "<Cmd>lua require('refactoring').refactor('Extract Block')<cr>", 'Extract Block', mode = { 'n' } },
        B = {
          "<Cmd>lua require('refactoring').refactor('Extract Function To File')<cr>",
          'Extract Function To File',
          mode = { 'n' },
        },
        i = { "<Cmd>lua require('refactoring').refactor('Inline Variable')<cr>", 'Inline Local', mode = { 'n' } },
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
        s = { "<Cmd>lua require('refactoring').select_refactor()<CR>", 'Select Refactor', mode = { 'n', 'v' } },
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
  }

  local split_mappings = function(maps, ft)
    local nmappings = {}
    local vmappings = {}

    local function check_mode(mapping, mode)
      if #mapping == 0 then
        return true
      end
      return vim.tbl_contains(mapping, mode)
    end

    local function remove_noisy(mapping, key)
      local count = 0
      for _ in pairs(mapping[key]) do
        count = count + 1
      end
      if count == 1 then
        mapping[key] = nil
      end
      return mapping
    end

    local function add_mapping(value, mode)
      local map = {}
      for key, mapping in pairs(value) do
        if key == 'name' then
          map.name = mapping
        elseif mapping.mode and check_mode(mapping.mode, mode) then
          map[key] = mapping
          map[key].mode = nil

          --
          if map[key].ft then
            if
              (map[key].ft.exclude and vim.tbl_contains(map[key].ft.exclude, ft))
              or (map[key].ft.only and #map[key].ft.only ~= 0 and not vim.tbl_contains(map[key].ft.only, ft))
            then
              map[key] = nil
            else
              map[key].ft = nil
            end
          end
        --
        elseif not mapping.mode and key ~= 'name' then
          map[key] = add_mapping(mapping, mode)
          map = remove_noisy(map, key)
        end
      end

      return map
    end

    for k, v in pairs(maps) do
      local copy_n = vim.deepcopy(v)
      local copy_v = vim.deepcopy(v)
      if v.mode then
        if check_mode(copy_n.mode, 'n') then
          nmappings[k] = copy_n
          if nmappings[k].cmd and copy_n.cmd then
            table.insert(nmappings[k], 1, copy_n.cmd.n)
            nmappings[k]['cmd'] = nil
          end
          nmappings[k]['mode'] = nil

          --
          if nmappings[k].ft then
            if
              (nmappings[k].ft.exclude and vim.tbl_contains(nmappings[k].ft.exclude, ft))
              or (
                nmappings[k].ft.only
                and #nmappings[k].ft.only ~= 0
                and not vim.tbl_contains(nmappings[k].ft.only, ft)
              )
            then
              nmappings[k] = nil
            else
              nmappings[k].ft = nil
            end
          end
          --
        end
        if check_mode(copy_v.mode, 'v') then
          vmappings[k] = copy_v
          if vmappings[k].cmd and copy_v.cmd then
            table.insert(vmappings[k], 1, copy_v.cmd.v)
            vmappings[k]['cmd'] = nil
          end
          vmappings[k]['mode'] = nil

          --
          if vmappings[k].ft then
            if
              (vmappings[k].ft.exclude and vim.tbl_contains(vmappings[k].ft.exclude, ft))
              or (
                vmappings[k].ft.only
                and #vmappings[k].ft.only ~= 0
                and not vim.tbl_contains(vmappings[k].ft.only, ft)
              )
            then
              vmappings[k] = nil
            else
              vmappings[k].ft = nil
            end
          end
          --
        end
      else
        vmappings[k] = add_mapping(copy_v, 'v')
        nmappings[k] = add_mapping(copy_n, 'n')
        vmappings = remove_noisy(vmappings, k)
      end
    end

    return nmappings, vmappings
  end

  local nmappings, vmappings = split_mappings(mappings_all)

  whichkey.setup(conf)

  whichkey.register(nmappings, opts)
  whichkey.register(vmappings, vopts)
  whichkey.register(m_mappings, m_opts)

  -- NOTE: add feature to detect keymap by file type
  -- ft = { only = { 'lua' }, exclude = { 'alpha' } },
  -- ft = { exclude = { 'lua' } },
  -- ft = { only = { 'lua' } },
  -- ft = { exclude = {} }, -- exclude all? for what?
  -- ft = { only = {} }, -- include all
  -- ft = {}, -- include all
  -- nil -- include all
  -- TODO: use nvim_create_autocmd on enter/leave buffer to set keymap
  -- TODO: check if that plugin is installed

  -- local group = vim.api.nvim_create_augroup('whichkey', { clear = true })
  -- local events = { 'BufEnter', 'BufWinEnter', 'CursorMoved' }
  -- vim.api.nvim_create_autocmd(events, {
  --   pattern = { '*' },
  --   callback = function()
  --     local fileType = vim.api.nvim_buf_get_option(0, 'filetype')
  --     nmappings, vmappings = split_mappings(mappings_all, fileType)
  --     whichkey.register(nmappings, opts)
  --     whichkey.register(vmappings, vopts)
  --   end,
  --   group = group,
  -- })
end

return M.setup()
