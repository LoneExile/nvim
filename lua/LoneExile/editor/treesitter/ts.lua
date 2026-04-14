local M = {}

M.setup = function(_, location)
  location = vim.fn.substitute(location, '.ts$', '', 'g')
  return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-textsubjects',
      'andymass/vim-matchup',
    },
    event = 'BufRead',
    build = function()
      ---@diagnostic disable-next-line: param-type-mismatch
      pcall(vim.cmd, 'TSUpdate')
    end,
    config = function()
      vim.g.skip_ts_context_commentstring_module = true

      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
        callback = function(args)
          vim.b[args.buf].match_disable_ts = 1
        end,
      })

      -- Neovim 0.12+ returns match[id] as a list; nvim-treesitter's
      -- query_predicates.lua assumes a single TSNode and crashes with
      -- "attempt to call method 'range' (a nil value)" on markdown injections.
      -- Re-register the broken directives/predicates with list-aware wrappers.
      pcall(require, 'nvim-treesitter.query_predicates')
      do
        local query = vim.treesitter.query
        local function unwrap(val)
          if type(val) == 'table' and val[1] ~= nil and type(val[1]) == 'userdata' then
            return val[1]
          end
          return val
        end

        local function get_parser_from_info_string(alias)
          local map = {
            bash = 'bash', sh = 'bash', shell = 'bash', zsh = 'bash',
            js = 'javascript', javascript = 'javascript',
            ts = 'typescript', typescript = 'typescript',
            py = 'python', python = 'python',
            rb = 'ruby', ruby = 'ruby',
            rs = 'rust', rust = 'rust',
            go = 'go', lua = 'lua', vim = 'vim', c = 'c', cpp = 'cpp',
            json = 'json', yaml = 'yaml', toml = 'toml', html = 'html', css = 'css',
          }
          return map[alias] or alias
        end

        query.add_directive('set-lang-from-info-string!', function(match, _, bufnr, pred, metadata)
          local node = unwrap(match[pred[2]])
          if not node then return end
          local alias = vim.treesitter.get_node_text(node, bufnr):lower()
          metadata['injection.language'] = get_parser_from_info_string(alias)
        end, { force = true, all = false })

        query.add_directive('downcase!', function(match, _, bufnr, pred, metadata)
          local node = unwrap(match[pred[2]])
          if not node then return end
          local text = vim.treesitter.get_node_text(node, bufnr)
          local id = pred[2]
          metadata[id] = metadata[id] or {}
          metadata[id].text = text:lower()
        end, { force = true, all = false })
      end

      local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
      if not status_ok then
        return
      end

      local tsTextObjects = require(location .. '.settings.tsTextObjects')

      local config = {
        -- ensure_installed = 'all',
        ensure_installed = {
          'markdown',
          'markdown_inline',
          'javascript',
          'typescript',
          'vue',
          'tsx',
          'css',
          'html',
          'json',
          'toml',
          'lua',
          'python',
          'bash',
          'yaml',
          'c',
          'cpp',
          'c_sharp',
          'rust',
          'diff',
          'heex', -- elixir
        },
        sync_install = false,
        auto_install = true,
        ignore_install = { '' },
        highlight = {
          enable = true,
          -- disable = function(lang, bufnr)
          --   -- disable treesitter for large files by file size
          --   local max_filesize = 2000 * 1024 -- 2 MB
          --   local js_max_filesize = 2000 * 1024 -- 2 MB
          --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
          --   if ok and stats and (stats.size > max_filesize or lang == 'js' and stats.size > js_max_filesize) then
          --     return true
          --   end

          --   -- disable treesitter for large files by line count
          --   local is_line_count = vim.api.nvim_buf_line_count(bufnr) > 5000
          --   local disabled_fts = { 'javascript', 'typescript' }
          --   for _, ft in ipairs(disabled_fts) do
          --     if lang == ft and is_line_count then
          --       return true
          --     end
          --   end
          -- end,

          disable = { '' },
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true, disable = { 'python', 'css' } },

        -- ** textobjects **
        textobjects = tsTextObjects,

        -- ** ts autopairs **
        autopairs = { enable = true },

        -- ** nvim-treesitter-textsubjects **
        textsubjects = {
          enable = true,
          prev_selection = ',', -- (Optional) keymap to select the previous selection
          keymaps = {
            ['.'] = 'textsubjects-smart',
            -- [";"] = "textsubjects-container-outer",
            -- ["i;"] = "textsubjects-container-inner",
          },
        },

        -- matchup
        matchup = {
          enable = false, -- disabled: treesitter engine crashes on markdown injections (falls back to regex)
        },
        -- ** markid ** better highlight (currently suck!?)
        -- markid = { enable = false },
      }

      treesitter.setup(config)
    end,
  }
end

return M
