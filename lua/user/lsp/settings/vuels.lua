local _, lspconfig = pcall(require, 'lspconfig')
-- https://github.com/neoclide/coc-vetur#configuration-options

local M = {}
M.setup = function(lsp)
  lsp.configure('vuels', {
    cmd = { 'vls' },
    filetypes = { 'vue' },
    root_dir = function(fname)
      return lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname)
        or lspconfig.util.path.dirname(fname)
    end,
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
  })
end
return M
