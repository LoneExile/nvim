local M = {}

M.wh_key = {
  wh_mappings = {
    x = {
      name = '+Execute',
      c = {
        name = '+Code',
        l = {
          name = '+Lab',
          r = { '<cmd>Lab code run<cr>', 'Run', mode = { 'n' } },
          s = { '<cmd>Lab code stop<cr>', 'Stop', mode = { 'n' } },
          p = { '<cmd>Lab code panel<cr>', 'Panel', mode = { 'n' } },
          c = { '<cmd>Lab code config<cr>', 'Config', mode = { 'n' } },
        },
      },
    },
  },
}

M.setup = function()
  return {
    '0x100101/lab.nvim',
    build = 'cd js && npm ci',
    cmd = { 'Lab' },
    ft = { 'javascript', 'typescript', 'lua', 'python' },
    config = function()
      local status_ok, lab = pcall(require, 'lab')
      if not status_ok then
        vim.notify('lab' .. ' not found!')
        return
      end
      lab.setup({
        code_runner = {
          enabled = true,
        },
        quick_data = {
          enabled = false,
        },
      })
    end,
  }
end

return M
