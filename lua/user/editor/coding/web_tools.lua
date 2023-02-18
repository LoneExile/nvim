local M = {}

M.setup = function()
  return {
    'ray-x/web-tools.nvim',
    lazy = true,
    cmd = { 'BrowserOpen', 'Browserstop', 'BrowserRestart' },
    ft = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    config = function()
      require('web-tools').setup()
    end,
  }
end

return M
