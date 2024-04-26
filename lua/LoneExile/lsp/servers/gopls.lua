local M = {}
M.setup = function(lspconfig, capabilities)
  lspconfig.gopls.setup({
    cmd = { 'gopls' },
    capabilities = capabilities,
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_dir = function(fname)
      return lspconfig.util.root_pattern('.golangci.yml', '.golangci.yaml', '.golangci.toml', '.golangci.json', 'go.work', 'go.mod', '.git')(fname)
        or lspconfig.util.path.dirname(fname)
    end,
    single_file_support = true,
  })
end

return M
