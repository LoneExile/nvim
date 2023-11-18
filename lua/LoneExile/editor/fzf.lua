local M = {}

M.wh_key = {
  wh_mappings = {
    -- lsp_declarations
    -- lsp_typedefs
    -- lsp_live_workspace_symbols
    l = {
      name = 'LSP',
      d = {
        '<cmd>FzfLua lsp_definitions<cr>',
        'Definitions',
        mode = { 'n' },
      },
      i = {
        '<cmd>FzfLua lsp_implementations<cr>',
        'Implementations',
        mode = { 'n' },
      },
      s = {
        '<cmd>FzfLua lsp_document_symbols<cr>',
        'Document Symbols',
        mode = { 'n' },
      },
      S = {
        '<cmd>FzfLua lsp_workspace_symbols<cr>',
        'Workspace Symbols',
        mode = { 'n' },
      },
      q = {
        '<cmd>FzfLua lsp_code_actions<cr>',
        'Code Actions',
        mode = { 'n' },
      },
      c = {
        '<cmd>FzfLua lsp_incoming_calls<cr>',
        'Incoming Calls',
        mode = { 'n' },
      },
      F = {
        '<cmd>FzfLua lsp_finder<cr>',
        'LSP Finder',
        mode = { 'n' },
      },
      C = {
        '<cmd>FzfLua lsp_outgoing_calls<cr>',
        'Outgoing Calls',
        mode = { 'n' },
      },
      r = {
        '<cmd>FzfLua lsp_references<cr>',
        'References',
        mode = { 'n' },
      },
      l = {
        '<cmd>FzfLua diagnostics_document<CR>',
        'Diagnostics',
        mode = { 'n' },
      },
      L = {
        '<cmd>FzfLua diagnostics_workspace<CR>',
        'Workspace Diagnostics',
        mode = { 'n' },
      },
    },

    ['s'] = {
      name = 'Search',
      b = {
        '<cmd>FzfLua buffers<cr>',
        'Buffers',
        mode = { 'n' },
      },
      f = {
        '<cmd>FzfLua files<cr>',
        'Find File',
        mode = { 'n' },
      },
      H = {
        '<cmd>FzfLua highlights<cr>',
        'Find highlight groups',
        mode = { 'n' },
      },
      o = {
        '<cmd>FzfLua oldfiles<cr>',
        'Open Recent File',
        mode = { 'n' },
      },
      r = {
        '<cmd>FzfLua resume<cr>',
        'Resume',
        mode = { 'n' },
      },
      c = {
        '<cmd>FzfLua builtin<cr>',
        'FZF commands',
        mode = { 'n', 'v' },
      },
      t = {
        '<cmd>FzfLua grep<cr>',
        'Text',
        mode = { 'n' },
      },
      T = {
        '<cmd>FzfLua grep_cword<cr>',
        'Text (string)',
        mode = { 'n', 'v' },
      },
      u = {
        '<cmd>FzfLua changes<cr>',
        'Undo',
        mode = { 'n' },
      },
      g = {
        '<cmd>FzfLua git_files<cr>',
        'Git Files',
        mode = { 'n' },
      },
    },
    ['g'] = {
      f = {
        '<cmd>FzfLua git_files<cr>',
        'Open changed file',
        mode = { 'n' },
      },
      x = {
        '<cmd>FzfLua git_status<cr>',
        'Open changed file',
        mode = { 'n' },
      },
      b = {
        '<cmd>FzfLua git_branches<cr>',
        'Checkout branch',
        mode = { 'n' },
      },
      c = {
        '<cmd>FzfLua git_commits<cr>',
        'Checkout commit',
        mode = { 'n' },
      },
      C = {
        '<cmd>FzfLua git_bcommits<cr>',
        'Checkout commit(for current file)',
        mode = { 'n' },
      },
      t = {
        '<cmd>FzfLua git_stash<cr>',
        'Stash',
        mode = { 'n' },
      },
    },
  },
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
}

M.setup = function(_, _)
  -- settings.utils.setup_mappings('<leader>', M.wh_key.wh_mappings, _)
  vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>FzfLua files<cr>', { noremap = true, silent = true, desc = 'Find Files' })
  return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = true,
    cmd = { 'FzfLua' },
    config = function()
      local status, fzf = pcall(require, 'fzf-lua')
      if not status then
        return
      end
      fzf.setup({})
    end,
  }
end

return M
