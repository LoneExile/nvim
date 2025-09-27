local utils = require('lsp._utils')

return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  stInfo = 'neovim',
  root_dir = utils.root_dir(utils.root_patterns.js_ts),
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
