local M = {}

M.keys = {
  {
    '<leader>t',
    '',
    desc = 'Test',
    mode = 'n',
  },
  {
    '<leader>tr',
    function()
      require('neotest').run.run()
    end,
    desc = 'Run Nearest',
    mode = 'n',
  },
  {
    '<leader>tR',
    function()
      require('neotest').run.run(vim.fn.expand('%'))
    end,
    desc = 'Run File',
    mode = 'n',
  },
  {
    '<leader>ts',
    function()
      require('neotest').summary.toggle()
    end,
    desc = 'Toggle Summary',
    mode = 'n',
  },
  {
    '<leader>to',
    function()
      require('neotest').output.open({ enter = true, auto_close = true })
    end,
    desc = 'Show Output',
    mode = 'n',
  },
  {
    '<leader>tO',
    function()
      require('neotest').output_panel.toggle()
    end,
    desc = 'Toggle Output Panel',
    mode = 'n',
  },
  {
    '<leader>tS',
    function()
      require('neotest').run.stop()
    end,
    desc = 'Stop',
    mode = 'n',
  },
  {
    '<leader>td',
    function()
      require('neotest').run({ strategy = 'dap' })
    end,
    desc = 'Debug Nearest',
    mode = 'n',
  },
}

M.setup = function()
  return {
    'nvim-neotest/neotest',
    ft = { 'go' },
    keys = M.keys,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neotest/nvim-nio',
      'nvim-treesitter/nvim-treesitter',
      -- 'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-go',
    },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace('neotest')
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)
      require('neotest').setup({
        -- your neotest config here
        adapters = {
          require('neotest-go'),
        },
      })
    end,
  }
end

return M
