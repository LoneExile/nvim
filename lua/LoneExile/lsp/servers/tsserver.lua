local M = {}

M.setup = function(lspconfig)
  lspconfig.tsserver.setup({
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
    hostInfo = 'neovim',
    root_dir = function(fname)
      return lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname) or lspconfig.util.path.dirname(fname)
    end,
    init_options = {
      hostInfo = 'neovim',
      -- preferences = {
      --   disableSuggestions = true,
      -- },
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
  })

  -------------------------------------------------------------------------
end

return M
