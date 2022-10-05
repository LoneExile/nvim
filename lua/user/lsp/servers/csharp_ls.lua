local M = {}

-- https://github.com/Decodetalkers/csharpls-extended-lsp.nvim
-- lua require('csharpls_extended').lsp_definitions()

-- NOTE: quickfix
-- dotnet clean
-- dotnet build
-- dotnet restore
-- dotnet new --list
-- dotnet --list-runtimes
-- dotnet --list-sdks

M.setup = function(lspconfig)
  lspconfig.csharp_ls.setup({
    cmd = { 'csharp-ls' },
    filetypes = { 'cs' },
    init_options = {
      AutomaticWorkspaceInit = true,
    },
    -- root_dir = function(fname)
    --   return lspconfig.util.root_pattern('*.sln', '*.csproj', '.git')(fname) or lspconfig.util.path.dirname(fname)
    -- end,
  })
end
return M
