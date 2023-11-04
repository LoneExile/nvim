local M = {}

M.wh_key = {
  wh_mappings = {
    t = {
      name = '+Test',
      c = {
        function()
          vim.cmd('CoverageToggle')
        end,
        'CoverageToggle',
        mode = { 'n' },
      },
      C = {
        function()
          vim.cmd('CoverageSummary')
        end,
        'CoverageSummary',
        mode = { 'n' },
      },
      l = {
        function()
          vim.cmd('CoverageLoad')
        end,
        'CoverageLoad',
        mode = { 'n' },
      },
    },
  },
}

M.setup = function()
  return {
    'andythigpen/nvim-coverage',
    -- ft = { 'go' },
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
