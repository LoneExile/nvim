local M = {}

M.setup = function(lspconfig)
  lspconfig.vale_ls.setup({
    cmd = { 'vale-ls' },
    filetypes = { 'markdown', 'text' },
    single_file_support = true,
  })
end
return M
