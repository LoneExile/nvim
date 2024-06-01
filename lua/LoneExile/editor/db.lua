local M = {}

M.wh_key = {
  wh_mappings = {
    D = {
      name = 'DBUI',
      '<cmd>DBUIToggle<CR>',
      'DBUI',
      mode = { 'n' },
    },
  },
}
print(vim.fn.stdpath('data'))
M.setup = function()
  return {
    'kristijanhusak/vim-dadbod-ui',
    cmd = {
      'DBUIToggle',
    },
    dependencies = {
      { 'tpope/vim-dadbod', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_win_position = 'right'
      vim.g.db_ui_save_location = vim.fn.stdpath('config') .. '/dadbod_queries'
      vim.g.db_ui_query_history_max_size = 100
      vim.g.db_ui_auto_execute_table_helpers = 1

      local cmp_ok, cmp = pcall(require, 'cmp')
      if not cmp_ok then
        return
      end
      cmp.setup.filetype({ 'sql' }, {
        sources = {
          { name = 'vim-dadbod-completion' },
          { name = 'buffer' },
        },
      })
    end,
  }
end

return M

-- postgresql://postgres:123456@localhost:5432/postgres
