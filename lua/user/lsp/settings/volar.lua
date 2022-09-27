-- local _, lspconfig = pcall(require, 'lspconfig')

local M = {}
M.setup = function(lsp)
  lsp.configure('volar', {
    cmd = { 'volar-server', '--stdio' },
    -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    filetypes = { 'vue' },
    -- root_dir = function(fname)
    --   return lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname)
    --     or lspconfig.util.path.dirname(fname)
    -- end,
    init_options = {
      documentFeatures = {
        documentColor = false,
        documentFormatting = {
          defaultPrintWidth = 100,
        },
        documentSymbol = true,
        foldingRange = true,
        linkedEditingRange = true,
        selectionRange = true,
      },
      languageFeatures = {
        callHierarchy = true,
        codeAction = true,
        codeLens = true,
        completion = {
          defaultAttrNameCase = 'kebabCase',
          defaultTagNameCase = 'both',
        },
        definition = true,
        diagnostics = true,
        documentHighlight = true,
        documentLink = true,
        hover = true,
        implementation = true,
        references = true,
        rename = true,
        renameFileRefactoring = true,
        schemaRequestService = true,
        semanticTokens = false,
        signatureHelp = true,
        typeDefinition = true,
      },
      typescript = {
        serverPath = '',
      },
    },
  })
end
return M
