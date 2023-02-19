local M = {}

M.setup = function(lspconfig)
  lspconfig.tsserver.setup({
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
    hostInfo = 'neovim',
    root_dir = function(fname)
      return lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname)
        or lspconfig.util.path.dirname(fname)
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
  -- See https://github.com/jose-elias-alvarez/typescript.nvim
  -- local status, typescript = pcall(require, 'typescript')
  -- if not status then
  --   print('ty')
  --   return
  -- end
  -- local status_ok, navic = pcall(require, 'nvim-navic')
  -- if not status_ok then
  --   print('tyy')
  --   return
  -- end
  -- typescript.setup({
  --   disable_commands = false, -- prevent the plugin from creating Vim commands
  --   debug = false, -- enable debug logging for commands
  --   go_to_source_definition = {
  --     fallback = true, -- fall back to standard LSP definition on failure
  --   },
  --   server = { -- pass options to lspconfig's setup method
  --     on_attach = function(client, bufnr)
  --       navic.attach(client, bufnr)
  --       vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  --     end,
  --   },
  -- })
end

return M
