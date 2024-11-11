local M = {}

M.keys = {
  {
    '<leader>t',
    function()
      local status, wk = pcall(require, 'which-key')
      if not status then
        return
      end
      wk.show({ global = false })
    end,
    desc = 'Test',
    mode = 'n',
  },
  {
    '<leader>tc',
    function()
      vim.cmd('CoverageToggle')
    end,
    desc = 'CoverageToggle',
    mode = 'n',
  },
  {
    '<leader>tC',
    function()
      vim.cmd('CoverageSummary')
    end,
    desc = 'CoverageSummary',
    mode = 'n',
  },
  {
    '<leader>tl',
    function()
      vim.cmd('CoverageLoad')
    end,
    desc = 'CoverageLoad',
    mode = 'n',
  },
}

M.setup = function()
  return {
    'andythigpen/nvim-coverage',
    -- ft = { 'go' },
    keys = M.keys,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = { 'CoverageLoad', 'CoverageToggle', 'CoverageSummary' },
    config = function()
      require('coverage').setup({
        commands = true,
        signs = {
          -- use your own highlight groups or text markers
          covered = { hl = 'CoverageCovered', text = '▎' },
          uncovered = { hl = 'CoverageUncovered', text = '▎' },
        },
        summary = {
          -- customize the summary pop-up
          min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
        },
        highlights = {
          covered = { fg = '#C3E88D' }, -- supports style, fg, bg, sp (see :h highlight-gui)
          uncovered = { fg = '#F07178' },
          partial = { fg = '#AA71F0' },
        },
      })
    end,
  }
end

return M
