-- NOTE: Functions converted to immediate values for Neovim 0.10+ compatibility
-- vim.lsp.config() cannot serialize functions
local omnisharp_path = vim.fn.glob(vim.fn.stdpath('data') .. '/mason/') .. 'packages/omnisharp/libexec/OmniSharp.dll'

local handlers
local status, handler = pcall(require, 'omnisharp_extended')
if status then
  handlers = {
    ['textDocument/definition'] = handler.definition_handler,
    ['textDocument/typeDefinition'] = handler.type_definition_handler,
    ['textDocument/references'] = handler.references_handler,
    ['textDocument/implementation'] = handler.implementation_handler,
  }
end

return {
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
      EnableAnalyzersSupport = nil,
      EnableImportCompletion = nil,
      AnalyzeOpenDocumentsOnly = nil,
      EnableDecompilationSupport = true,
    },
    Sdk = {
      IncludePrereleases = true,
    },
  },
  handlers = handlers,
}
