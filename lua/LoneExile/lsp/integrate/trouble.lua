local M = {}
M.wh_key = {
  wh_mappings = {
    l = {
      name = 'LSP',
      t = { '<cmd>TroubleToggle<cr>', 'Trouble', mode = { 'n' } },
      r = { '<cmd>TroubleToggle lsp_references<cr>', 'References', mode = { 'n' } },
      d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'DiagnosticsBuf', mode = { 'n' } },
      D = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Diagnostics', mode = { 'n' } },
      q = { '<cmd>TroubleToggle quickfix<cr>', 'Quickfix', mode = { 'n' } },
      c = { '<cmd>TroubleToggle loclist<cr>', 'Loclist', mode = { 'n' } },
    },
  },
}

M.setup = function(_, _)
  return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'TroubleToggle', 'Trouble' },
  }
end

return M
