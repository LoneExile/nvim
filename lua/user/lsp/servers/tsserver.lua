local status, typescript = pcall(require, 'typescript')
if not status then
  return
end

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
    },
    settings = {
      completions = {
        completeFunctionCalls = true,
      },
    },
  })

  -- See https://github.com/jose-elias-alvarez/typescript.nvim
  typescript.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
      fallback = true, -- fall back to standard LSP definition on failure
    },
    -- server = { -- pass options to lspconfig's setup method
    --   on_attach = function(client, bufnr)
    --     -- ...
    --   end,
    -- },
  })
end

return M
