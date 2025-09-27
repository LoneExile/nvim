return {
  cmd = { 'csharp-ls' },
  filetypes = { 'cs' },
  init_options = {
    AutomaticWorkspaceInit = true,
  },
  root_dir = function(fname)
    local lspconfig = require('lspconfig')
    return lspconfig.util.root_pattern('*.sln', '*.csproj', '.git')(fname) or lspconfig.util.path.dirname(fname)
  end,
}
