local M = {}

M.setup = function(setting, location)
  return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'InsertEnter' },
    cmd = { 'ConformInfo' },
    config = function()
      local status_ok, conform = pcall(require, 'conform')
      if not status_ok then
        return
      end

      local util = require('conform.util')

      local configLoc = setting.conf_loc .. '/resources/null-ls/'

      -- TODO: if current file is in neovim config, use that config
      require('conform.formatters.stylua').args = { '--config-path', vim.fn.glob(configLoc .. '.stylua.toml'), '$FILENAME', '-' }
      require('conform.formatters.stylua').range_args = function(ctx)
        local start_offset, end_offset = util.get_offsets_from_range(ctx.buf, ctx.range)
        return {
          -- "--search-parent-directories",
          '--config-path',
          vim.fn.glob(configLoc .. '.stylua.toml'),
          '--stdin-filepath',
          '$FILENAME',
          '--range-start',
          tostring(start_offset),
          '--range-end',
          tostring(end_offset),
          '-',
        }
      end

      conform.setup({
        formatters_by_ft = {
          lua = { 'stylua' },
          -- Conform will run multiple formatters sequentially
          python = { 'isort', 'black' },
          -- Use a sub-list to run only the first available formatter
          javascript = { { 'prettierd', 'prettier' } },

          yaml = { 'yamlfmt' },
          json = { 'jq' },

          ['*'] = { 'codespell' },
          ['_'] = { 'trim_whitespace' },
        },

        -- format_on_save = {
        --   timeout_ms = 1000,
        --   lsp_fallback = true,
        -- },
      })

      vim.api.nvim_create_user_command('Format', function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ['end'] = { args.line2, end_line:len() },
          }
        end
        require('conform').format({ async = false, timeout_ms = 1000, lsp_fallback = true, range = range })
      end, { range = true })
    end,
  }
end

return M
