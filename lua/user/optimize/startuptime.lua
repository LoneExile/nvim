local M = {}

M.enabled = true

M.wh_key = {
  enabled = M.enabled,
  wh_mappings = {
    N = {
      name = 'Neovim',
      s = { '<cmd>StartupTime<cr>', 'Startup Time', mode = { 'n' } },
    },
  },
}

M.setup = function()
  return {
    'dstein64/vim-startuptime',
    enabled = M.enabled,
    lazy = true,
    cmd = 'StartupTime',
    config = function()
      local group = vim.api.nvim_create_augroup('autocmd_startuptime', { clear = true })

      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = {
          'startuptime',
        },
        callback = function(event)
          -- Open help vertically and press q to exit
          vim.api.nvim_cmd({ cmd = 'wincmd', args = { 'L' } }, {})

          vim.bo[event.buf].buflisted = false
          vim.keymap.set('n', 'q', '<CMD>q<CR>', { buffer = event.buf, silent = true })
        end,
      })
    end,
  }
end

return M
