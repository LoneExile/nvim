-- M = {}

local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  vim.notify('null_ls' .. ' not found!')
  return
end
local formatting = null_ls.builtins.formatting

local format = {
  formatting.prettier.with({
    filetypes = {
      'javascript',
      'typescript',
      'typescriptreact',
      'javascriptreact',
      'html',
      'css',
      'scss',
      'lua',
      'vue',
      'yaml',
    },
    extra_args = { '--no-semi', '--single-quote', '--no-bracket-spacing', '--print-width', '120', '--prose-wrap', 'always' },
    disabled_filetypes = { 'lua', 'python' },
    extra_filetypes = { 'toml' },
  }),

  formatting.prettier.with({
    filetypes = { 'markdown' },
    extra_args = { '--print-width', '80', '--prose-wrap', 'always' },
  }),

  formatting.yamlfmt.with({
    filetypes = { 'yaml' },
    extra_args = { '-' },
  }),

  formatting.jq.with({
    filetypes = { 'json' },
  }),

  formatting.stylua.with({
    filetypes = { 'lua' },
    extra_args = { '-f', vim.fn.stdpath('config') .. '/resources/null-ls/.stylua.toml' },
  }),

  formatting.black.with({
    filetypes = { 'python' },
    extra_args = { '--fast', '--line-length', '90' },
  }),

  formatting.beautysh.with({
    filetypes = { 'bash', 'csh', 'ksh', 'sh', 'zsh' },
    extra_args = { '$FILENAME' },
  }),

  formatting.csharpier.with({
    filetypes = { 'cs' },
    command = 'dotnet-csharpier',
    extra_args = { '--write-stdout' },
  }),
  -- formatting.clang_format.with({
  --   filetypes = { 'cs' },
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

  formatting.xmlformat.with({
    filetypes = { 'xml', 'svg' },
    command = 'xmlformat',
    extra_args = { '-' },
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

  -- formatting.clang_format.with({
  --   command = 'clang-format',
  --   filetypes = { 'c', 'cpp', 'cs', 'java', 'cuda', 'proto' },
  -- }),
}

-- return M
return format
