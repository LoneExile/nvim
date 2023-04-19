local M = {}

M.enabled = true

M.wh_key = {
  enabled = M.enabled,
  wh_mappings = {
    x = {
      name = '+Execute',
      b = {
        name = '+Browser',
        s = { '<cmd>Browserstop<cr>', 'Stop', mode = { 'n' } },
        o = { '<cmd>BrowserOpen<cr>', 'Open', mode = { 'n' } },
        r = { '<cmd>BrowserRestart<cr>', 'Restart', mode = { 'n' } },
      },
    },
  },
}

M.setup = function()
  return {
    'ray-x/web-tools.nvim',
    cmd = { 'BrowserOpen', 'Browserstop', 'BrowserRestart' },
    ft = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    config = function()
      require('web-tools').setup()
    end,
  }
end

return M
