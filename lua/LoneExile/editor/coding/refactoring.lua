local M = {}

M.enabled = false

M.wh_key = {
  enabled = M.enabled,
  wh_mappings = {
    x = {
      name = '+Execute',
      r = {
        name = 'Refactor',
        b = {
          "<Cmd>lua require('refactoring').refactor('Extract Block')<cr>",
          'Extract Block',
          mode = { 'n' },
        },
        B = {
          "<Cmd>lua require('refactoring').refactor('Extract Function To File')<cr>",
          'Extract Function To File',
          mode = { 'n' },
        },
        i = {
          "<Cmd>lua require('refactoring').refactor('Inline Variable')<cr>",
          'Inline Local',
          mode = { 'n' },
        },
        f = {
          "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>",
          'Extract Function',
          mode = { 'v' },
        },
        F = {
          "<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
          'Extract Function To File',
          mode = { 'v' },
        },
        v = {
          "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>",
          'Extract Variable',
          mode = { 'v' },
        },
        V = {
          "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable To File')<CR>",
          'Extract Variable To File',
          mode = { 'v' },
        },
        s = {
          "<Cmd>lua require('refactoring').select_refactor()<CR>",
          'Select Refactor',
          mode = { 'n', 'v' },
        },
      },
    },
  },
}

M.setup = function()
  return {
    'theprimeagen/refactoring.nvim',
    enabled = M.enabled,
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
