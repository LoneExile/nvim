local M = {}

-- M.ft = { 'markdown', 'md', 'html' }

M.keys = function()
  -- if not vim.tbl_contains(M.ft, vim.bo.filetype) then
  --   return {}
  -- end

  return {
    {
      '<leader>um',
      '',
      desc = 'Markdown',
      mode = 'n',
    },
    {
      '<leader>ums',
    function()
        vim.cmd('LivePreview stop')
        vim.cmd('LivePreview start')
    end,
      mode = 'n',
      desc = 'Markdown Live Preview Start',
    },
    {
      '<leader>umc',
      '<cmd>LivePreview close<CR>',
      mode = 'n',
      desc = 'Markdown Live Preview Close',
    },
    {
      '<leader>ump',
      '<cmd>LivePreview pick<CR>',
      mode = 'n',
      desc = 'Markdown Live Preview Pick',
    },
  }
end

M.setup = function()
  return {
    'brianhuster/live-preview.nvim',
    cmd = { 'LivePreview' },
    keys = M.keys,
    dependencies = {
      'ibhagwan/fzf-lua',
    },
  }
end

return M
