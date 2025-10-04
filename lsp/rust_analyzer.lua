return {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  -- Note: root_dir removed - functions cannot be serialized with vim.lsp.enable()
  -- The default root_dir from lspconfig will be used (looks for Cargo.toml, rust-project.json, .git, etc.)
  settings = {
    ['rust-analyzer'] = {
      lens = {
        enable = true,
      },
      checkOnSave = {
        enable = true,
        command = 'clippy',
      },
    },
  },
}
