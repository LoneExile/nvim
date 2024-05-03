local M = {}

M.setup = function(lspconfig, capabilities)
  lspconfig.docker_compose_language_service.setup({
    cmd = { 'docker-compose-langserver', '--stdio' },
    capabilities = capabilities,
    filetypes = { 'yaml.docker-compose' },
    root_dir = lspconfig.util.root_pattern('docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml'),
    single_file_support = true,
  })
end

return M
