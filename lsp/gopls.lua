return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  -- Note: root_dir removed - functions cannot be serialized with vim.lsp.enable()
  -- The default root_dir from lspconfig will be used (looks for go.mod, go.work, .git, etc.)
  single_file_support = true,
}
