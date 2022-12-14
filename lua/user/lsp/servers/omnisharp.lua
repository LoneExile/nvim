local M = {}

local omnisharp_path = vim.fn.glob(vim.fn.stdpath('data') .. '/mason/') .. 'packages/omnisharp/OmniSharp.dll'

M.setup = function(lspconfig)
  lspconfig.omnisharp.setup({
    cmd = { 'dotnet', omnisharp_path },
    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.

    enable_editorconfig_support = true,

    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,

    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = true,

    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = false,

    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = true,

    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,

    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,

    filetypes = { 'cs', 'vb' },
    init_options = {},

    -- https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
    on_attach = function(client, _)
      client.server_capabilities.semanticTokensProvider.legend = {
        tokenModifiers = { 'static' },
        tokenTypes = {
          'comment',
          'excluded',
          'identifier',
          'keyword',
          'keyword',
          'number',
          'operator',
          'operator',
          'preprocessor',
          'string',
          'whitespace',
          'text',
          'static',
          'preprocessor',
          'punctuation',
          'string',
          'string',
          'class',
          'delegate',
          'enum',
          'interface',
          'module',
          'struct',
          'typeParameter',
          'field',
          'enumMember',
          'constant',
          'local',
          'parameter',
          'method',
          'method',
          'property',
          'event',
          'namespace',
          'label',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'xml',
          'regexp',
          'regexp',
          'regexp',
          'regexp',
          'regexp',
          'regexp',
          'regexp',
          'regexp',
          'regexp',
        },
      }
    end,
  })
end
return M
