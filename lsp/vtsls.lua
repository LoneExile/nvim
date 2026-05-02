-- vtsls: TypeScript Language Server wrapper. Replaces typescript-language-server
-- in this config. The vue typescript-plugin registration below makes vtsls
-- understand .vue files when paired with vue_ls (lsp/vue_ls.lua).
local mason = vim.fn.stdpath('data') .. '/mason'
local vue_plugin = mason .. '/packages/vue-language-server/node_modules/@vue/language-server'

return {
  cmd = { 'vtsls', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
  },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue_plugin,
            languages = { 'vue' },
            configNamespace = 'typescript',
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
    typescript = {
      preferences = {
        importModuleSpecifier = 'non-relative',
        quoteStyle = 'single',
      },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = false },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    javascript = {
      preferences = {
        importModuleSpecifier = 'non-relative',
        quoteStyle = 'single',
      },
    },
  },
}
