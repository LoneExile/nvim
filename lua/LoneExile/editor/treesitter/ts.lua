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
      local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
      if not status_ok then
        return
      end

      local status, commentConfig = pcall(require, location .. '.settings.commentString')
      if not status then
        commentConfig = {}
        vim.notify('Treesitter comment config not found')
      end

      local tsTextObjects = require(location .. '.settings.tsTextObjects')

      configs.setup({
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

        -- **nvim-ts-context-commentstring**
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
          config = commentConfig,
        },

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
          enable = true, -- mandatory, false will disable the whole extension
          disable = { 'c', 'ruby' }, -- optional, list of language that will be disabled
          -- [options]
        },
        -- ** markid ** better highlight (currently suck!?)
        -- markid = { enable = false },
      })
    end,
  }
end

return M
