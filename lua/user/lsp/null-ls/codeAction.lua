local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  vim.notify('null_ls' .. ' not found!')
  return
end
local code_actions = null_ls.builtins.code_actions

local codeAction = {
  -- code_actions
  -- code_actions.refactoring.with({
  -- 	filetype = { "go", "javascript", "lua", "python", "typescript" },
  -- }),
  code_actions.eslint.with({
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
    },
    extra_args = {
      -- "-f",
      -- "json",
      -- "--stdin",
      -- "--stdin-filename",
      -- "$FILENAME",
      '--no-eslintrc',
      '--env',
      'es6',
    },
  }),
  code_actions.shellcheck.with({
    extra_args = { '--severity', 'warning' },
  }),
  -- code_actions.gitsigns.with({
  -- 	-- disabled_filetypes = { "lua" },
  -- }),
}

return codeAction
