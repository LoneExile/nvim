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
    },
    extra_args = { '--no-semi', '--single-quote', '--no-bracket-spacing' },
    disabled_filetypes = { 'lua', 'python' },
    extra_filetypes = { 'toml' },
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
    -- extra_args = { "--column-width", "120" },
  }),

  formatting.black.with({
    filetypes = { 'python' },
    extra_args = { '--fast', '--line-length', '90' },
  }),

  formatting.shfmt.with({
    filetypes = { 'bash', 'csh', 'ksh', 'sh', 'zsh' },
    extra_args = { '-filename', '$FILENAME' },
  }),

  formatting.csharpier.with({
    filetypes = { 'cs' },
    command = 'dotnet-csharpier',
    extra_args = { '--write-stdout' },
  }),

  formatting.markdownlint.with({
    filetypes = { 'markdown' },
    extra_args = { '--fix' },
  }),
}

-- return M
return format
