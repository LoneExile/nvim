return {
  filetypes = { 'go', 'gomod' },
  -- NOTE: root_dir function removed for Neovim 0.10+ compatibility
  -- vim.lsp.config() cannot serialize functions
  -- Using default lspconfig root_dir pattern (looks for .golangci.yml, go.work, go.mod, .git, etc.)
  command = { 'golangci-lint', 'run', '--out-format', 'json' },
}
