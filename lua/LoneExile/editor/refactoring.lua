local M = {}

M.keys = {
  {
    '<leader>r',
    "<Cmd>lua require('refactoring').select_refactor()<CR>",
    desc = 'Refactor',
    mode = 'n',
  },
}

M.setup = function()
  return {
    'theprimeagen/refactoring.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    lazy = true,
    -- ft = { 'go', 'javascript', 'lua', 'python', 'typescript' },
    keys = M.keys,
    config = function()
      local status_ok_ui, refactoring = pcall(require, 'refactoring')
      if not status_ok_ui then
        return
      end

      refactoring.setup({
        prompt_func_return_type = {
          go = false,
          java = false,

          cpp = false,
          c = false,
          h = false,
          hpp = false,
          cxx = false,
        },
        prompt_func_param_type = {
          go = false,
          java = false,

          cpp = false,
          c = false,
          h = false,
          hpp = false,
          cxx = false,
        },
        printf_statements = {},
        print_var_statements = {},
      })

      local status, telescope = pcall(require, 'telescope')
      if status then
        telescope.load_extension('refactoring')
      end
    end,
  }
end

return M
