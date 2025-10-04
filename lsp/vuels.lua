return {
  cmd = { 'vls' },
  filetypes = { 'vue' },
  -- Note: root_dir removed - functions cannot be serialized with vim.lsp.enable()
  -- The default root_dir from lspconfig will be used (looks for package.json, etc.)
  init_options = {
    config = {
      css = {},
      emmet = {},
      html = {
        suggest = {},
      },
      javascript = {
        format = {},
      },
      stylusSupremacy = {},
      typescript = {
        format = {},
      },
      vetur = {
        completion = {
          autoImport = false,
          tagCasing = 'kebab',
          useScaffoldSnippets = false,
        },
        format = {
          defaultFormatter = {
            js = 'prettier',
            ts = 'prettier',
          },
          defaultFormatterOptions = {},
          scriptInitialIndent = false,
          styleInitialIndent = false,
        },
        useWorkspaceDependencies = false,
        validation = {
          script = true,
          style = true,
          template = true,
        },
      },
    },
  },
}
