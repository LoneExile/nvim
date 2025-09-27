return {
  cmd = { 'docker-compose-langserver', '--stdio' },
  filetypes = { 'yaml.docker-compose' },
  root_dir = function(fname)
    local lspconfig = require('lspconfig')
    return lspconfig.util.root_pattern('docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml')(fname)
  end,
  single_file_support = true,
}
