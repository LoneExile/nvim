local M = {}

M.setup = function(null_ls, _)
  local code_actions = null_ls.builtins.code_actions

  local codeAction = {
    -- ts_utils,
    code_actions.eslint_d.with({
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
    code_actions.refactoring.with({
      filetype = { 'go', 'javascript', 'lua', 'python', 'typescript' },
    }),

    -- NOTE: Go
    code_actions.impl.with({
      filetypes = { 'go' },
    }),
    code_actions.gomodifytags.with({
      filetypes = { 'go' },
    }),

    -- code_actions.gitsigns.with({
    -- 	-- disabled_filetypes = { "lua" },
    -- }),
  }

  -- typescript.nvim
  -- local status, ts_utils = pcall(require, 'typescript.extensions.null-ls.code-actions')
  -- if status then
  --   table.insert(codeAction, ts_utils)
  -- end

  return codeAction
end

return M
