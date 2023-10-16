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

      local status, linters = pcall(require, 'lint.linters')
      if not status then
        return
      end

      linters.alex = {
        cmd = 'alex',
        stdin = false,
        args = { '--stdin' },
        stream = 'stdout',
        ignore_exitcode = true,
        parser = function(output)
          local diagnostics = {}
          for line in output:gmatch('[^\r\n]+') do
            local _, _, line_nr, col_start, col_end, msg = line:find('(%d+):(%d+)-(%d+): (.*)')
            table.insert(diagnostics, {
              source = 'alex',
              range = {
                ['start'] = { line = tonumber(line_nr) - 1, character = tonumber(col_start) - 1 },
                ['end'] = { line = tonumber(line_nr) - 1, character = tonumber(col_end) },
              },
              message = msg,
              severity = vim.lsp.protocol.DiagnosticSeverity.Warning,
            })
          end
          return diagnostics
        end,
      }

      lint.linters_by_ft = {
        -- alex
        -- refactoring

        -- impl
        -- gomodifytags

        javascript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        vue = { 'eslint_d' },

        go = { 'golangcilint' },

        markdown = { 'markdownlint', 'alex' },
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
