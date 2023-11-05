local M = {}

M.setup = function(setting, _)
  return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'InsertEnter' },
    config = function()
      local status_ok, lint = pcall(require, 'lint')
      if not status_ok then
        return
      end

      local configLoc = setting.conf_loc .. '/resources/null-ls/'

      local luacheck = lint.linters.luacheck
      luacheck.args = { '--config', configLoc .. '.luacheckrc' }

      local shellcheck = lint.linters.shellcheck
      shellcheck.args = {
        '--severity',
        'warning',
        '--format',
        'json',
        '-',
      }

      local markdownlint = lint.linters.markdownlint
      markdownlint.args = {
        '--config',
        configLoc .. '.markdownlint.json',
        '--stdin',
      }

      lint.linters_by_ft = {

        -- # linters
        -- alex

        -- # code_actions
        -- ## Go ##
        -- impl
        -- gomodifytags

        javascript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        vue = { 'eslint_d' },

        go = { 'golangcilint' },

        markdown = { 'markdownlint' },
        lua = { 'luacheck' },

        python = { 'ruff' },
        yaml = { 'actionlint' },

        zsh = { 'shellcheck' },
        sh = { 'shellcheck' },
        bash = { 'shellcheck' },
        csh = { 'shellcheck' },

        groovy = { 'npm-groovy-lint' },
      }

      -- for ft, _ in pairs(lint.linters_by_ft) do
      --   table.insert(lint.linters_by_ft[ft], 'codespell')
      -- end

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  }
end

return M
