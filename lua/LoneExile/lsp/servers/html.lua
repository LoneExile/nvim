local M = {}

M.setup = function(lspconfig, capabilities)
  lspconfig.html.setup({
    cmd = { 'vscode-html-language-server', '--stdio' },
    capabilities = capabilities,
    filetypes = { 'html', 'templ' },
    init_options = {
      configurationSection = { 'html', 'css', 'javascript' },
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
      provideFormatter = false,
    },
    single_file_support = true,
  })
end

return M
