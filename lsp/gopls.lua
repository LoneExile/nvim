local utils = require('lsp._utils')

return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = utils.root_dir(utils.root_patterns.go),
  single_file_support = true,
}
