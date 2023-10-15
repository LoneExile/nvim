local M = {}

M.setup = function(setting, location)
  return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'InsertEnter' },
    config = function()
      local status_ok, lint = pcall(require, 'lint')
      if not status_ok then
        return
      end

      local configLoc = setting.conf_loc .. '/resources/null-ls/'

      local luacheck = require('lint').linters.luacheck
      luacheck.args = { '--config', configLoc .. '.luacheckrc' }

      local shellcheck = require('lint').linters.shellcheck
      shellcheck.args = {
        '--severity',
        'warning',
        '--format',
        'json',
        '-',
      }

      local markdownlint = require('lint').linters.markdownlint
      markdownlint.args = {
        '--config',
        configLoc .. '.markdownlint.json',
        '--stdin',
      }

      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        lua = { 'luacheck' },

        python = { 'ruff' },
        yaml = { 'actionlint' },

        zsh = { 'shellcheck' },
        sh = { 'shellcheck' },
        bash = { 'shellcheck' },
        csh = { 'shellcheck' },
      }

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
