return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = function(fname)
    local lspconfig = require('lspconfig')
    return lspconfig.util.root_pattern('.golangci.yml', '.golangci.yaml', '.golangci.toml', '.golangci.json', 'go.work', 'go.mod', '.git')(fname)
      or lspconfig.util.path.dirname(fname)
  end,
  single_file_support = true,
}
