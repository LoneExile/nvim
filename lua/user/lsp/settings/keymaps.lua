local M = {}

local buffer_mappings_default = {
  normal_mode = {
    ['K'] = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'Show hover' },
    ['gd'] = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Goto Definition' },
    ['gs'] = { vim.lsp.buf.signature_help, 'show signature help' },
    ['gr'] = { '<cmd>lua vim.lsp.buf.references()<cr>', 'Goto references' },
    ['gR'] = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'rename' },
    ['gq'] = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action' },
    ['gj'] = { '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Next diagnostic' },
    ['gk'] = { '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Prev diagnostic' },
    ['gD'] = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Goto declaration' },
    ['go'] = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Goto Implementation' },
    ['gI'] = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Goto Implementation' },
    ['gl'] = { '<cmd>lua vim.diagnostic.open_float()<cr>', 'Show line diagnostics' },
    -- ['gf'] = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format' },
  },
  insert_mode = {},
  visual_mode = {
    ['gq'] = { '<Esc><cmd>lua vim.lsp.buf.range_code_action()<cr>', 'Code action' },
  },
}

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
    ['gl'] = { '<cmd>Lspsaga show_line_diagnostics<cr>', 'Show line diagnostics' },
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
    local status, _ = pcall(require, 'lspsaga')
    if status then
      for key, remap in pairs(buffer_mappings[mode_name]) do
        local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
        vim.keymap.set(mode_char, key, remap[1], opts)
      end
    else
      for key, remap in pairs(buffer_mappings_default[mode_name]) do
        local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
        vim.keymap.set(mode_char, key, remap[1], opts)
      end
    end
  end
end

return M
