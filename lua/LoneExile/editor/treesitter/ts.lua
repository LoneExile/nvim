local M = {}

-- ts.lua: nvim-treesitter `main` branch integration.
--
-- Behavior contract (verified against upstream):
--   * On FileType, we resolve filetype -> parser language via
--     vim.treesitter.language.get_lang(ft). vim.treesitter.language.add(lang)
--     returns (true) on success or (nil, errmsg) on failure -- it does NOT
--     raise -- so we capture the tuple instead of using pcall.
--     Source: runtime/lua/vim/treesitter/language.lua
--   * If the parser is missing, we synchronously install it (bounded 60s)
--     and notify the user, then re-add and attach.
--   * Foldexpr is set BUFFER-LOCALLY via vim.wo[0][0] so it never leaks to
--     other windows under :bufdo / :tabnew / :edit-from-other-window.
--   * Comment.nvim is preserved in comment.lua with its full config AND its
--     pre_hook on ts_context_commentstring -- this is load-bearing because
--     Comment.nvim's resolver is pre_hook -> F.calculate(ctx) -> bo.commentstring
--     and F.calculate uses an internal hardcoded `L` table (never
--     vim.filetype.get_option). Source: lua/Comment/utils.lua and ft.lua.
--   * Matchup TS engine is intentionally disabled (regex fallback). vim-matchup
--     has no upstream fix for the markdown-injection crash class.
--   * Background-prime runs on User VeryLazy so startup is not blocked.

M.ensure_installed = {
  'markdown', 'markdown_inline', 'javascript', 'typescript', 'vue', 'tsx',
  'css', 'html', 'json', 'toml', 'lua', 'python', 'bash', 'yaml',
  'c', 'cpp', 'c_sharp', 'rust', 'diff',
  'heex', 'elixir', -- elixir injects into heex; both required
  'go', 'vim', 'vimdoc', 'query',
}

M.setup = function(_, _)
  return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = function()
      pcall(function()
        require('nvim-treesitter').install(M.ensure_installed):wait(300000)
      end)
    end,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
      { 'andymass/vim-matchup' },
      -- ts-comments retained as a redundant safety net for non-Comment.nvim
      -- consumers; not load-bearing for our gcc path (that goes through
      -- Comment.nvim's pre_hook in comment.lua).
      { 'folke/ts-comments.nvim', opts = {} },
    },
    config = function()
      -- Defer the parser background-prime to VeryLazy so we don't iterate
      -- 22 langs on every startup. Build hook (above) handles :Lazy sync.
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        once = true,
        callback = function()
          pcall(function()
            require('nvim-treesitter').install(M.ensure_installed)
          end)
        end,
      })

      -- Per-session sentinel: don't re-trigger install for the same lang.
      local installed_in_session = {}

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('UserTsAttach', { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if not lang or lang == '' then return end

          -- vim.treesitter.language.add returns (nil, errmsg) on failure;
          -- it does NOT raise. Use the tuple form, not pcall.
          local added, add_err = vim.treesitter.language.add(lang)
          if not added then
            if not installed_in_session[lang] then
              installed_in_session[lang] = true
              vim.notify(
                ('[treesitter] installing parser %s ...'):format(lang),
                vim.log.levels.INFO
              )
              local ok_install = pcall(function()
                require('nvim-treesitter').install({ lang }):wait(60000)
              end)
              if not ok_install then
                vim.notify(
                  ('[treesitter] install failed/timeout for %s: %s')
                    :format(lang, add_err or 'unknown'),
                  vim.log.levels.WARN
                )
                return
              end
              local readded, readd_err = vim.treesitter.language.add(lang)
              if not readded then
                vim.notify(
                  ('[treesitter] add still failed after install for %s: %s')
                    :format(lang, readd_err or 'unknown'),
                  vim.log.levels.WARN
                )
                return
              end
            else
              return
            end
          end

          local ok, err = pcall(vim.treesitter.start, ev.buf, lang)
          if not ok then
            vim.notify(
              ('[treesitter] start failed for %s: %s'):format(ev.match, err),
              vim.log.levels.WARN
            )
            return
          end

          -- Buffer-local foldexpr (window 0, buffer 0 -> sticks to this buf).
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldmethod = 'expr'

          -- Buffer-local indentexpr if the language has indents.scm.
          -- Known limitation: errors may surface at `=` reformat time on
          -- langs where core ships indents.scm but main lacks it.
          local has_indent = vim.treesitter.query.get(lang, 'indents') ~= nil
          if has_indent then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      pcall(function()
        require('nvim-treesitter-textobjects').setup({
          select = { lookahead = true },
        })
      end)

      local map = vim.keymap.set
      local sel_ok, sel = pcall(require, 'nvim-treesitter-textobjects.select')
      if sel_ok then
        local function pick(obj)
          return function() sel.select_textobject(obj, 'textobjects') end
        end
        for _, m in ipairs({ 'x', 'o' }) do
          map(m, 'af', pick('@function.outer'))
          map(m, 'if', pick('@function.inner'))
          map(m, 'ac', pick('@class.outer'))
          map(m, 'ic', pick('@class.inner'))
          map(m, 'aa', pick('@parameter.outer'))
          map(m, 'ia', pick('@parameter.inner'))
          map(m, 'ab', pick('@block.outer'))
          map(m, 'ib', pick('@block.inner'))
          map(m, 'al', pick('@loop.outer'))
          map(m, 'il', pick('@loop.inner'))
          map(m, 'is', pick('@statement.inner'))
          map(m, 'as', pick('@statement.outer'))
          map(m, 'ad', pick('@comment.outer'))
          map(m, 'am', pick('@call.outer'))
          map(m, 'im', pick('@call.inner'))
        end
      end

      local move_ok, move = pcall(require, 'nvim-treesitter-textobjects.move')
      if move_ok then
        map('n', ']m', function() move.goto_next_start('@function.outer', 'textobjects') end)
        map('n', ']]', function() move.goto_next_start('@class.outer', 'textobjects') end)
        map('n', ']M', function() move.goto_next_end('@function.outer', 'textobjects') end)
        map('n', ']['  , function() move.goto_next_end('@class.outer', 'textobjects') end)
        map('n', '[m', function() move.goto_previous_start('@function.outer', 'textobjects') end)
        map('n', '[[', function() move.goto_previous_start('@class.outer', 'textobjects') end)
        map('n', '[M', function() move.goto_previous_end('@function.outer', 'textobjects') end)
        map('n', '[]', function() move.goto_previous_end('@class.outer', 'textobjects') end)
      end

      local swap_ok, swap = pcall(require, 'nvim-treesitter-textobjects.swap')
      if swap_ok then
        map('n', '<leader>xp', function() swap.swap_next('@parameter.inner') end)
        map('n', '<leader>xP', function() swap.swap_previous('@parameter.inner') end)
      end

      -- :TSStatus diagnostic. pcall around vim.b[b] access is forward-compat
      -- insurance; current Neovim returns nil for missing keys without error.
      vim.api.nvim_create_user_command('TSStatus', function()
        local attached = {}
        for _, b in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(b) then
            local ok_b, ts = pcall(function() return vim.b[b].ts_highlight end)
            if ok_b and ts then
              local ft = vim.bo[b].filetype
              attached[ft] = (attached[ft] or 0) + 1
            end
          end
        end
        print(vim.inspect({
          attached_by_ft = attached,
          installed_in_session = vim.tbl_keys(installed_in_session),
        }))
      end, {})
    end,
  }
end

return M
