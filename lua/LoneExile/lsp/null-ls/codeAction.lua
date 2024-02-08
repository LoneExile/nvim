local M = {}

M.setup = function(null_ls, _)
  local code_actions = null_ls.builtins.code_actions

  local codeAction = {
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

  return codeAction
end

return M
