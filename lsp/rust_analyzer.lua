return {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  settings = {
    ['rust-analyzer'] = {
      lens = {
        enable = true,
      },
      checkOnSave = {
        enable = true,
        command = 'clippy',
      },
    },
  },
  root_dir = function(fname)
    local lspconfig = require('lspconfig')
    return lspconfig.util.root_pattern('Cargo.toml', 'rust-project.json', '.git')(fname) or lspconfig.util.path.dirname(fname)
  end,
}
