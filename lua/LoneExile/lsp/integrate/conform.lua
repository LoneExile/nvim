local M = {}

M.setup = function(s, _)
  return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'InsertEnter' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>w',
        '<cmd>Format<CR>',
        mode = { 'n', 'v' },
        desc = 'Format Injected Langs',
      },
    },
    config = function()
      local status_ok, conform = pcall(require, 'conform')
      if not status_ok then
        return
      end

      local util = require('conform.util')

      local configLoc = s.utils.convert_path(s.conf_loc .. '/resources/null-ls/')

      conform.setup({
        log_level = vim.log.levels.DEBUG,
        formatters = {
          ['markdown-toc'] = {
            condition = function(_, ctx)
              for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
                if line:find('<!%-%- toc %-%->') then
                  return true
                end
              end
            end,
          },
          ['markdownlint-cli2'] = {
            condition = function(_, ctx)
              local diag = vim.tbl_filter(function(d)
                return d.source == 'markdownlint'
              end, vim.diagnostic.get(ctx.buf))
              return #diag > 0
            end,
          },

          sqlfluff = {
            args = { 'format', '--dialect=ansi', '-' },
          },

          csharpier = {
            command = 'dotnet-csharpier',
            args = { '--write-stdout' },
          },
          -- TODO: if current file is in neovim config, use that config
          stylua = {
            command = 'stylua',
            args = { '--config-path', vim.fn.glob(configLoc .. '.stylua.toml'), '$FILENAME', '-' },
            range_args = function(_, ctx)
              local start_offset, end_offset = util.get_offsets_from_range(ctx.buf, ctx.range)
              return {
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
            end,
          },
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          ['markdown'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
          ['markdown.mdx'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
          python = { 'isort', 'black' },
          javascript = { 'prettier', stop_after_first = true },
          htmlangular = { 'prettier' },
          typescript = { 'prettier' },
          typescriptreact = { 'prettier' },
          javascriptreact = { 'prettier' },
          vue = { 'prettier' },
          html = { 'prettier' },
          css = { 'prettier' },
          scss = { 'prettier' },
          astro = { 'prettier' },

          groovy = { 'npm_groovy_lint' },

          -- $HOME/.config/yamlfmt/.yamlfmt
          yaml = { 'yamlfmt' },
          json = { 'jq' },

          bash = { 'shfmt' },
          csh = { 'shfmt' },
          ksh = { 'shfmt' },
          sh = { 'shfmt' },
          zsh = { 'shfmt' },

          sql = { 'pg_format', 'sql_formatter' },
          plpgsql = { 'pg_format', 'sql_formatter' },

          xml = { 'xmlformat' },
          svg = { 'xmlformat' },
          go = { 'goimports', 'gofumpt', 'golines' },
          elm = { 'elm_format' },
          cs = { 'csharpier' },

          -- ['*'] = { 'codespell' },
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
        require('conform').format({ async = false, timeout_ms = 5000, lsp_fallback = true, range = range })
        vim.cmd('w!')
      end, { range = true })
    end,
  }
end

return M
