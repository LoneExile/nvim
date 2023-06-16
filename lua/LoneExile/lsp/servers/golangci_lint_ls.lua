local M = {}
M.setup = function(lspconfig)
  lspconfig.golangci_lint_ls.setup({
    filetypes = { 'go', 'gomod' },
    root_dir = function(fname)
      return lspconfig.util.root_pattern('.golangci.yml', '.golangci.yaml', '.golangci.toml', '.golangci.json', 'go.work', 'go.mod', '.git')(fname)
        or lspconfig.util.path.dirname(fname)
    end,
    command = { 'golangci-lint', 'run', '--out-format', 'json' },
  })
end

return M
