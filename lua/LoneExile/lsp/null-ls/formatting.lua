local M = {}

M.setup = function(null_ls, s)
  local formatting = null_ls.builtins.formatting

  local format = {
    formatting.prettierd.with({
      filetypes = { 'markdown' },
      extra_args = { '--print-width', '80', '--prose-wrap', 'always' },
    }),

    formatting.yamlfmt.with({
      filetypes = { 'yaml' },
      extra_args = { '-' },
    }),

    formatting.stylua.with({
      filetypes = { 'lua' },
      extra_args = { '-f', s.conf_loc .. s.utils.convert_path('/resources/null-ls/.stylua.toml') },
    }),

    formatting.black.with({
      filetypes = { 'python' },
      extra_args = { '--fast', '--line-length', '90' },
    }),

    formatting.shfmt.with({
      filetypes = { 'bash', 'csh', 'ksh', 'sh', 'zsh' },
    }),

    -- formatting.csharpier.with({
    --   filetypes = { 'cs' },
    --   command = 'dotnet-csharpier',
    --   extra_args = { '--write-stdout' },
    -- }),

    formatting.markdownlint.with({
      filetypes = { 'markdown' },
      extra_args = { '--fix', '$FILENAME' },
    }),

    -- formatting.remark.with({
    --   filetypes = { 'markdown' },
    --   extra_args = { '--no-color', '--silent' },
    -- }),
    formatting.sql_formatter.with({
      filetypes = { 'sql' },
    }),

    -- https://github.com/darold/pgFormatter
    formatting.pg_format.with({
      filetypes = { 'sql', 'plpgsql' },
    }),

    -- formatting.xmlformat.with({
    --   filetypes = { 'xml', 'svg' },
    --   command = 'xmlformat',
    --   extra_args = { '-' },
    -- }),

    formatting.npm_groovy_lint.with({
      filetypes = { 'groovy', 'java', 'Jenkinsfile' },
    }),

    formatting.golines.with({
      extra_args = {
        '--max-len=120',
        '--base-formatter=gofumpt',
      },
    }),

    formatting.goimports.with({
      command = 'goimports',
      extra_args = { '-srcdir', '$DIRNAME' },
      filetypes = { 'go' },
    }),
  }
  return format
end

return M
-- return format
