local M = {}

M.setup = function(null_ls, s)
  local diagnostics = null_ls.builtins.diagnostics

  local diagnosticsTable = {
    diagnostics.markdownlint.with({
      filetypes = { 'markdown' },
      extra_args = {
        '--stdin',
        'c',
        s.conf_loc .. s.utils.convert_path('/resources/null-ls/.markdownlint.json'),
      },
    }),

    diagnostics.alex.with({
      filetypes = { 'markdown' },
      extra_args = { '--stdin' },
    }),

    -- diagnostics.luacheck.with({
    --   filetype = { 'lua' },
    --   extra_args = { '--config', s.conf_loc .. s.utils.convert_path('/resources/null-ls/.luacheckrc') },
    -- }),

    diagnostics.selene.with({
      filetype = { 'lua' },
      extra_args = { '--config', s.conf_loc .. s.utils.convert_path('/resources/null-ls/selene.toml') },
    }),

    diagnostics.zsh.with({
      filetypes = { 'zsh' },
      extra_args = { '-n', '$FILENAME' },
    }),

    diagnostics.actionlint.with({
      filetype = { 'yaml' },
    }),
    diagnostics.npm_groovy_lint.with({
      filetype = { 'groovy', 'java', 'Jenkinsfile' },
    }),

    -- diagnostics.sqlfluff.with({
    --   filetype = { 'sql' },
    --   extra_args = { '--dialect', 'postgres' },
    -- }),
  }
  return diagnosticsTable
end

return M
