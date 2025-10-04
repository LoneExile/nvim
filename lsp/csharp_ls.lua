return {
  cmd = { 'csharp-ls' },
  filetypes = { 'cs' },
  init_options = {
    AutomaticWorkspaceInit = true,
  },
  -- NOTE: root_dir function removed for Neovim 0.10+ compatibility
  -- vim.lsp.config() cannot serialize functions
  -- Using default lspconfig root_dir pattern (looks for *.sln, *.csproj, .git)
}
