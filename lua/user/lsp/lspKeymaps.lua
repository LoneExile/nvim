local status_ok_ui, lsp = pcall(require, "lsp-zero")
if not status_ok_ui then
  return
end

local buffer_mappings = {
  normal_mode = {
    ["K"] = { "<cmd>Lspsaga hover_doc<CR>", "Show hover" },
    ["gd"] = { "<cmd>Lspsaga peek_definition<CR>", "Goto Definition" },
    ["gs"] = { vim.lsp.buf.signature_help, "show signature help" },
    ["gr"] = { "<cmd>Lspsaga lsp_finder<CR>", "Goto references" },
    ["gR"] = { "<cmd>Lspsaga rename<CR>", "rename" },
    ["gq"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
    ["gj"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next diagnostic" },
    ["gk"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev diagnostic" },
    ["gD"] = { vim.lsp.buf.declaration, "Goto declaration" },
    ["gI"] = { vim.lsp.buf.implementation, "Goto Implementation" },
    ["gl"] = {
      "<cmd>Lspsaga show_line_diagnostics<cr>",
      "Show line diagnostics",
    },
  },
  insert_mode = {},
  visual_mode = {
    ["gq"] = { "<Esc><cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
  },
}

local function add_lsp_buffer_keybindings(bufnr)
  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }
  for mode_name, mode_char in pairs(mappings) do
    for key, remap in pairs(buffer_mappings[mode_name]) do
      local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
      vim.keymap.set(mode_char, key, remap[1], opts)
    end
  end
end

lsp.on_attach(function(client, bufnr)
  add_lsp_buffer_keybindings(bufnr)
end)
