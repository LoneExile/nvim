if vim.fn.has('nvim-0.7') ~= 1 then
  print('Please upgrade your Neovim base installation.requires v0.8+')
  vim.wait(5000, function()
    return false
  end)
  vim.cmd('cquit')
end

local M = {}

vim.g.python_host_prog = '$HOME/.pyenv/shims/python'
vim.g.python3_host_prog = '$HOME/.pyenv/versions/nvim/bin/python3'
vim.opt.clipboard = 'unnamedplus' -- allows neovim to access the system clipboard

M.CURRENTOS = vim.loop.os_uname().sysname
M.TRANPARENT = true

if M.CURRENTOS == 'Darwin' then
  M.TRANPARENT = true
  vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = {
      ['+'] = 'pbcopy',
      ['*'] = 'pbcopy',
    },
    paste = {
      ['+'] = 'pbpaste',
      ['*'] = 'pbpaste',
    },
    cache_enabled = 0,
  }
end

if M.CURRENTOS == 'windows' or M.CURRENTOS == 'windows_nt' then
  M.TRANPARENT = false
  vim.g.clipboard = {
    name = 'win32yank',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
  vim.g.python_host_prog = '$HOME\\scoop\\apps\\pyenv\\current\\pyenv-win\\shims\\python.bat'
  vim.g.python3_host_prog = '$HOME\\scoop\\apps\\pyenv\\current\\pyenv-win\\shims\\python3.bat'
end

return M
