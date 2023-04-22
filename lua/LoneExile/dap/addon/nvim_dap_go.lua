local M = {}

M.setup = function()
  return {
    'leoluz/nvim-dap-go',
    ft = { 'go' },
    build = 'go install github.com/go-delve/delve/cmd/dlv@latest',
    config = function()
      require('dap-go').setup()
    end,
  }
end

return M
