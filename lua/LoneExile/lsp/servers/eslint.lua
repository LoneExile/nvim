local M = {}

M.setup = function(lspconfig)
  lspconfig.eslint.setup({
    cmd = { 'vscode-eslint-language-server', '--stdio' },
    root_dir = lspconfig.util.root_pattern('.eslintrc', '.eslintrc.js', '.eslintrc.json', '.eslintrc.ts'),
    settings = {
      format = {
        enable = true,
      },
    },
    on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        command = 'EslintFixAll',
      })
    end,
    handlers = {
      -- this error shows up occasionally when formatting
      -- formatting actually works, so this will supress it
      ['window/showMessageRequest'] = function(_, result)
        if result.message:find('ENOENT') then
          return vim.NIL
        end

        return vim.lsp.handlers['window/showMessageRequest'](nil, result)
      end,
    },
  })
end

return M
