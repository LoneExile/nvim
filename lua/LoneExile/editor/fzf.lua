local M = {}

M.keys = {
  -- LSP
  {
    '<leader>l',
    function()
      local status, wk = pcall(require, 'which-key')
      if not status then
        return
      end
      wk.show({ global = false })
    end,
    desc = 'LSP',
    mode = 'n',
  },
  {
    '<leader>ld',
    '<cmd>FzfLua lsp_definitions<cr>',
    desc = 'Definitions',
    mode = 'n',
  },
  {
    '<leader>li',
    '<cmd>FzfLua lsp_implementations<cr>',
    desc = 'Implementations',
    mode = 'n',
  },
  {
    '<leader>ls',
    '<cmd>FzfLua lsp_document_symbols<cr>',
    desc = 'Document Symbols',
    mode = 'n',
  },
  {
    '<leader>lS',
    '<cmd>FzfLua lsp_workspace_symbols<cr>',
    desc = 'Workspace Symbols',
    mode = 'n',
  },
  {
    '<leader>lq',
    '<cmd>FzfLua lsp_code_actions<cr>',
    desc = 'Code Actions',
    mode = 'n',
  },
  {
    '<leader>lc',
    '<cmd>FzfLua lsp_incoming_calls<cr>',
    desc = 'Incoming Calls',
    mode = 'n',
  },
  {
    '<leader>lF',
    '<cmd>FzfLua lsp_finder<cr>',
    desc = 'LSP Finder',
    mode = 'n',
  },
  {
    '<leader>lC',
    '<cmd>FzfLua lsp_outgoing_calls<cr>',
    desc = 'Outgoing Calls',
    mode = 'n',
  },
  {
    '<leader>lr',
    '<cmd>FzfLua lsp_references<cr>',
    desc = 'References',
    mode = 'n',
  },
  {
    '<leader>ll',
    '<cmd>FzfLua diagnostics_document<CR>',
    desc = 'Diagnostics',
    mode = 'n',
  },
  {
    '<leader>lL',
    '<cmd>FzfLua diagnostics_workspace<CR>',
    desc = 'Workspace Diagnostics',
    mode = 'n',
  },

  -- Search
  {
    '<leader>s',
    function()
      local status, wk = pcall(require, 'which-key')
      if not status then
        return
      end
      wk.show({ global = false })
    end,
    desc = 'Search',
    mode = 'n',
  },
  {
    '<leader>sb',
    '<cmd>FzfLua buffers<cr>',
    desc = 'Buffers',
    mode = 'n',
  },
  {
    '<leader>sf',
    '<cmd>FzfLua files<cr>',
    desc = 'Find File',
    mode = 'n',
  },
  {
    '<leader>sH',
    '<cmd>FzfLua highlights<cr>',
    desc = 'Find highlight groups',
    mode = 'n',
  },
  {
    '<leader>so',
    '<cmd>FzfLua oldfiles<cr>',
    desc = 'Open Recent File',
    mode = 'n',
  },
  {
    '<leader>sr',
    '<cmd>FzfLua resume<cr>',
    desc = 'Resume',
    mode = 'n',
  },
  {
    '<leader>sc',
    '<cmd>FzfLua builtin<cr>',
    desc = 'FZF commands',
    mode = { 'n', 'v' },
  },
  {
    '<leader>st',
    '<cmd>FzfLua grep<cr>',
    desc = 'Text',
    mode = 'n',
  },
  {
    '<leader>sT',
    '<cmd>FzfLua grep_cword<cr>',
    desc = 'Text (string)',
    mode = { 'n', 'v' },
  },
  {
    '<leader>su',
    '<cmd>FzfLua changes<cr>',
    desc = 'Undo',
    mode = 'n',
  },
  {
    '<leader>sg',
    '<cmd>FzfLua git_files<cr>',
    desc = 'Git Files',
    mode = 'n',
  },
  {
    '<leader>sq',
    '<cmd>FzfLua quickfix<cr>',
    desc = 'Quickfix',
    mode = 'n',
  },
  {
    '<leader>sQ',
    '<cmd>FzfLua quickfix_stack<cr>',
    desc = 'Quickfix Stack',
    mode = 'n',
  },
  {
    '<leader>sl',
    '<cmd>FzfLua loclist<cr>',
    desc = 'Location List',
    mode = 'n',
  },
  {
    '<leader>sL',
    '<cmd>FzfLua loclist_stack<cr>',
    desc = 'Location List Stack',
    mode = 'n',
  },
  {
    '<leader>sB',
    '<cmd>FzfLua tabs<cr>',
    desc = 'Tabs',
    mode = 'n',
  },

  -- Git
  -- {
  --   '<leader>g',
  --   function()
  --     local status, wk = pcall(require, 'which-key')
  --     if not status then
  --       return
  --     end
  --     wk.show({ global = false })
  --   end,
  --   desc = 'Git',
  --   mode = 'n',
  -- },
  {
    '<leader>gf',
    '<cmd>FzfLua git_files<cr>',
    desc = 'Open changed file',
    mode = 'n',
  },
  {
    '<leader>gx',
    '<cmd>FzfLua git_status<cr>',
    desc = 'Open changed file',
    mode = 'n',
  },
  {
    '<leader>gb',
    '<cmd>FzfLua git_branches<cr>',
    desc = 'Checkout branch',
    mode = 'n',
  },
  {
    '<leader>gc',
    '<cmd>FzfLua git_commits<cr>',
    desc = 'Checkout commit',
    mode = 'n',
  },
  {
    '<leader>gC',
    '<cmd>FzfLua git_bcommits<cr>',
    desc = 'Checkout commit(for current file)',
    mode = 'n',
  },
  {
    '<leader>gt',
    '<cmd>FzfLua git_stash<cr>',
    desc = 'Stash',
    mode = 'n',
  },
}

-- wh_g_mappings = {
--   ['d'] = { '<cmd>FzfLua lsp_definitions<CR>', 'Goto Definition', mode = { 'n' } },
--   ['o'] = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Peek type definition', mode = { 'n' } },
--   ['O'] = { '<cmd>FzfLua lsp_typedefs<CR>', 'Peek type definition', mode = { 'n' } },
--   ['s'] = { vim.lsp.buf.signature_help, 'show signature help', mode = { 'n' } },
--   ['r'] = { '<cmd>FzfLua lsp_references<CR>', 'Goto references', mode = { 'n' } },
--   ['R'] = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'rename' },
--   ['q'] = { '<cmd>FzfLua lsp_code_actions<CR>', 'Code action', mode = { 'n', 'v' } },
--   ['j'] = { '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Next diagnostic', mode = { 'n' } },
--   ['k'] = { '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Prev diagnostic', mode = { 'n' } },
--   ['l'] = { '<cmd>lua vim.diagnostic.open_float()<cr>', 'Show line diagnostics', mode = { 'n' } },
--   ['D'] = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Goto declaration', mode = { 'n' } },
--   ['I'] = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Goto Implementation', mode = { 'n' } },
-- },

M.setup = function(_, _)
  -- settings.utils.setup_mappings('<leader>', M.wh_key.wh_mappings, _)
  vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>FzfLua files<cr>', { noremap = true, silent = true, desc = 'Find Files' })
  -- vim.api.nvim_set_keymap('n', '<C-q>', '<cmd>FzfLua quickfix_stack<cr>', { noremap = true, silent = true, desc = 'Quickfix' })
  return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = true,
    cmd = { 'FzfLua' },
    keys = M.keys,
    config = function()
      local status, fzf = pcall(require, 'fzf-lua')
      if not status then
        return
      end
      local actions = require('fzf-lua.actions')
      fzf.setup({
        keymap = {
          builtin = {
            ['<F1>'] = 'toggle-help',
            ['<F2>'] = 'toggle-fullscreen',
            -- Only valid with the 'builtin' previewer
            ['<F3>'] = 'toggle-preview-wrap',
            ['<F4>'] = 'toggle-preview',
            ['<F5>'] = 'toggle-preview-ccw',
            ['<F6>'] = 'toggle-preview-cw',
            ['<S-down>'] = 'preview-page-down',
            ['<S-up>'] = 'preview-page-up',
            ['<S-left>'] = 'preview-page-reset',
          },
          fzf = {
            ['alt-a'] = 'toggle-all',
            ['ctrl-q'] = 'select-all+accept',
          },
        },
        actions = {
          files = {
            ['default'] = actions.file_edit_or_qf,
            ['ctrl-v'] = actions.file_split,
            ['ctrl-s'] = actions.file_vsplit,
            ['ctrl-t'] = actions.file_tabedit,
            ['alt-q'] = actions.file_sel_to_qf,
            ['alt-l'] = actions.file_sel_to_ll,
          },
        },
        lines = {
          actions = {
            ['default'] = actions.buf_edit_or_qf,
            ['alt-q'] = actions.buf_sel_to_qf,
            ['alt-l'] = actions.buf_sel_to_ll,
          },
        },
        blines = {
          actions = {
            ['default'] = actions.buf_edit_or_qf,
            ['alt-q'] = actions.buf_sel_to_qf,
            ['alt-l'] = actions.buf_sel_to_ll,
          },
        },
      })
    end,
  }
end

return M
