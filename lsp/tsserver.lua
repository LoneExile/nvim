return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  hostInfo = 'neovim',
  -- Note: root_dir removed - functions cannot be serialized with vim.lsp.enable()
  -- The default root_dir from lspconfig will be used (looks for package.json, tsconfig.json, etc.)
  init_options = {
    hostInfo = 'neovim',
    preferences = {
      allowRenameOfImportPath = true,
      importModuleSpecifierEnding = 'auto',
      importModuleSpecifierPreference = 'non-relative',
      includeCompletionsForImportStatements = true,
      includeCompletionsForModuleExports = true,
      quotePreference = 'single',
    },
  },
  settings = {
    completions = {
      completeFunctionCalls = true,
    },
  },
}
