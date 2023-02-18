if vim.fn.has('nvim-0.8') ~= 1 then
  print('Please upgrade your Neovim base installation.requires v0.9+')
  vim.wait(5000, function()
    return false
  end)
  vim.cmd('cquit')
end

local M = {}

M.CURRENTOS = vim.loop.os_uname().sysname
M.TRANPARENT = true

M.SETPYENV = function()
  local python3 = io.popen('which python3')
  if python3 then
    vim.g.python3_host_prog = python3:read()
    python3:close()
  end

  local python = io.popen('which python')
  if python then
    vim.g.python_host_prog = python:read()
    python:close()
  end
end

if M.CURRENTOS == 'Linux' then
  M.SETPYENV()
  M.TRANPARENT = true
  vim.opt.clipboard = 'unnamedplus' -- allows neovim to access the system clipboard
end

if M.CURRENTOS == 'Darwin' then
  M.SETPYENV()
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
