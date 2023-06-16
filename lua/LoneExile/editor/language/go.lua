local M = {}

M.setup = function()
  return {
    'olexsmir/gopher.nvim',
    ft = { 'go' },
    cmd = {
      'GoTagAdd',
      'GoTagRm',
      'GoMod',
      'GoGet',
      'GoImpl',
      'GoTestAdd',
      'GoTestsAll',
      'GoTestsExp',
      'GoGenerate',
      'GoCmt',
      'GoIfErr',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('gopher').setup({
        commands = {
          go = 'go',
          gomodifytags = 'gomodifytags',
          gotests = vim.fn.glob(vim.fn.stdpath('data') .. '/mason/') .. 'bin/gotests',
          impl = 'impl',
          iferr = 'iferr',
        },
      })
    end,
  }
end

return M
