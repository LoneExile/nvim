local M = {}

M.setup = function()
  return {
    '0x100101/lab.nvim',
    build = 'cd js && npm ci',
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
