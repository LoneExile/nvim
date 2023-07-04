local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  vim.notify('null_ls' .. ' not found!')
  return
end
local diagnostics = null_ls.builtins.diagnostics

local diagnosticsTable = {
  diagnostics.markdownlint.with({
    filetypes = { 'markdown' },
    extra_args = {
      '--stdin',
      'c',
      vim.fn.stdpath('config') .. '/resources/null-ls/.markdownlint.json',
    },
  }),
  -- write good is good though
  -- diagnostics.write_good.with({
  --   filetypes = { 'markdown' },
  --   extra_args = { '--text=$TEXT', '--parse' },
  -- }),
  diagnostics.alex.with({
    filetypes = { 'markdown' },
    extra_args = { '--stdin' },
  }),

  diagnostics.luacheck.with({
    filetype = { 'lua' },
    extra_args = { '--config', vim.fn.stdpath('config') .. '/resources/null-ls/.luacheckrc' },
  }),
  diagnostics.shellcheck.with({
    filetypes = { 'bash', 'csh', 'ksh', 'sh', 'zsh' },
    extra_args = { '--severity', 'warning' },
  }),

  -- diagnostics.flake8.with({
  --   filetypes = { 'python' },
  --   extra_args = { '--max-line-length', '90' },
  -- }),

  diagnostics.ruff.with({
    filetypes = { 'python' },
    extra_args = { '-n', '-e', '--stdin-filename', '$FILENAME', '-' },
  }),

  -- diagnostics.eslint_d.with({
  --   filetypes = {
  --     'javascript',
  --     'javascriptreact',
  --     'typescript',
  --     'typescriptreact',
  --     -- 'vue',
  --   },
  --   extra_args = {
  --     '-f',
  --     'json',
  --     '--stdin',
  --     '--stdin-filename',
  --     '$FILENAME',
  --     -- '--no-eslintrc',
  --     -- '--env',
  --     -- 'es6',
  --   },
  -- }),

  diagnostics.zsh.with({
    filetypes = { 'zsh' },
    extra_args = { '-n', '$FILENAME' },
  }),

  diagnostics.actionlint.with({
    filetype = { 'yaml' },
  }),

  -- diagnostics.sqlfluff.with({
  --   filetype = { 'sql' },
  --   extra_args = { '--dialect', 'postgres' },
  -- }),

  -- NOTE: not working, use LSP instead
  -- diagnostics.golangci_lint.with({
  --   filetype = { 'go' },
  --   extra_args = { 'run', '--fix=false', '--out-format=json', '--path-prefix', '$ROOT' },
  --   command = 'golangci-lint',
  --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  -- }),

  diagnostics.cpplint.with({
    filetype = { 'c', 'cpp' },
    command = 'cpplint',
    extra_args = { '$FILENAME' },
  }),
}

return diagnosticsTable
