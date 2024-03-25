local M = {}

M.wh_key = {
  wh_mappings = {
    t = {
      name = '+Test',
      r = {
        function()
          require('neotest').run.run()
        end,
        'Run Nearest',
        mode = { 'n' },
      },
      R = {
        function()
          require('neotest').run.run(vim.fn.expand('%'))
        end,
        'Run File',
        mode = { 'n' },
      },
      s = {
        function()
          require('neotest').summary.toggle()
        end,
        'Toggle Summary',
        mode = { 'n' },
      },
      o = {
        function()
          require('neotest').output.open({ enter = true, auto_close = true })
        end,
        'Show Output',
        mode = { 'n' },
      },
      O = {
        function()
          require('neotest').output_panel.toggle()
        end,
        'Toggle Output Panel',
        mode = { 'n' },
      },
      S = {
        function()
          require('neotest').run.stop()
        end,
        'Stop',
        mode = { 'n' },
      },
      d = {
        function()
          require('neotest').run.run({ strategy = 'dap' })
        end,
        'Debug Nearest',
        mode = { 'n' },
      },
    },
  },
}

M.setup = function()
  return {
    'nvim-neotest/neotest',
    ft = { 'go' },
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
