return {
  cmd = { 'docker-compose-langserver', '--stdio' },
  filetypes = { 'yaml.docker-compose' },
  -- NOTE: root_dir function removed for Neovim 0.10+ compatibility
  -- vim.lsp.config() cannot serialize functions
  -- Using default lspconfig root_dir pattern (looks for docker-compose.yaml/yml, compose.yaml/yml)
  single_file_support = true,
}
