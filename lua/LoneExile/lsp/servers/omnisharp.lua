local M = {}

M.setup = function(lspconfig)
  local omnisharp_path = vim.fn.glob(vim.fn.stdpath('data') .. '/mason/') .. 'packages/omnisharp/libexec/OmniSharp.dll'
  local config = {
    cmd = { 'dotnet', omnisharp_path },
    filetypes = { 'cs', 'vb' },
    init_options = {},
    settings = {
      FormattingOptions = {
        EnableEditorConfigSupport = true,
        OrganizeImports = nil,
      },
      MsBuild = {
        LoadProjectsOnDemand = nil,
      },
      RoslynExtensionsOptions = {
        -- Enables support for roslyn analyzers, code fixes and rulesets.
        EnableAnalyzersSupport = nil,
        -- Enables support for showing unimported types and unimported extension
        -- methods in completion lists. When committed, the appropriate using
        -- directive will be added at the top of the current file. This option can
        -- have a negative impact on initial completion responsiveness,
        -- particularly for the first few completion sessions after opening a
        -- solution.
        EnableImportCompletion = nil,
        -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
        -- true
        AnalyzeOpenDocumentsOnly = nil,
        EnableDecompilationSupport = true,
      },
      Sdk = {
        IncludePrereleases = true,
      },
    },
  }

  local status, handler = pcall(require, 'omnisharp_extended')
  if status then
    config.handlers = {
      ['textDocument/definition'] = handler.definition_handler,
      ['textDocument/typeDefinition'] = handler.type_definition_handler,
      ['textDocument/references'] = handler.references_handler,
      ['textDocument/implementation'] = handler.implementation_handler,
    }
  end

  lspconfig.omnisharp.setup(config)
end

return M
