local M = {}

-- TODO: if lspsaga not load use default
-- ('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
-- ('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
-- ('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
-- ('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
-- ('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
-- ('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
-- ('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
-- ('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
-- ('n', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
-- ('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
-- ('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
-- ('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
-- ('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
-- ('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

local buffer_mappings = {
  normal_mode = {
    ['K'] = { '<cmd>Lspsaga hover_doc<CR>', 'Show hover' },
    ['gd'] = { '<cmd>Lspsaga peek_definition<CR>', 'Goto Definition' },
    ['gs'] = { vim.lsp.buf.signature_help, 'show signature help' },
    ['gr'] = { '<cmd>Lspsaga lsp_finder<CR>', 'Goto references' },
    ['gR'] = { '<cmd>Lspsaga rename<CR>', 'rename' },
    ['gq'] = { '<cmd>Lspsaga code_action<CR>', 'Code action' },
    ['gj'] = { '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next diagnostic' },
    ['gk'] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Prev diagnostic' },
    ['gD'] = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Goto declaration' },
    ['go'] = { '<cmd>Lspsaga goto_definition<cr>', 'Goto Implementation' },
    ['gI'] = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Goto Implementation' },
    ['gl'] = {
      '<cmd>Lspsaga show_line_diagnostics<cr>',
      'Show line diagnostics',
    },
  },
  insert_mode = {},
  visual_mode = {
    ['gq'] = { '<Esc><cmd>lua vim.lsp.buf.code_action()<CR>', 'Code action' },
  },
}

function M.add_lsp_buffer_keybindings(bufnr)
  local mappings = {
    normal_mode = 'n',
    insert_mode = 'i',
    visual_mode = 'v',
  }
  for mode_name, mode_char in pairs(mappings) do
    for key, remap in pairs(buffer_mappings[mode_name]) do
      local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
      vim.keymap.set(mode_char, key, remap[1], opts)
    end
  end
end

return M
