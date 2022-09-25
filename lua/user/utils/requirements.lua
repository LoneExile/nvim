if vim.fn.has('nvim-0.7') ~= 1 then
  print('Please upgrade your Neovim base installation.requires v0.8+')
  vim.wait(5000, function()
    return false
  end)
  vim.cmd('cquit')
end

local M = {}

M.CURRENTOS = vim.loop.os_uname().sysname
M.TRANPARENT = true

if M.CURRENTOS == 'Darwin' then
  TRANPARENT = false
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
  vim.g.python_host_prog = '/usr/bin/python'
  vim.g.python3_host_prog = '/usr/local/bin/python3'
end

-- windows -- MINGW64_NT-10.0
if M.CURRENTOS == 'windows' or M.CURRENTOS == 'windows_nt' then
  TRANPARENT = false
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
  vim.g.python_host_prog = 'c:\\users\\bunlaikun\\scoop\\apps\\pyenv\\current\\pyenv-win\\shims\\python.bat'
  vim.g.python3_host_prog = 'c:\\users\\bunlaikun\\scoop\\apps\\pyenv\\current\\pyenv-win\\shims\\python3.bat'
end

return M
------------------------------------------------------------------------------

-- local fn = vim.fn
-- local install_path = fn.stdpath('data') .. '/site/pack/packer/start/'
-- local pluginTable = require('user.core.plugins')
-- local _, packer = pcall(require, 'packer')

-- local isInstall = true
-- for _, plugin in ipairs(pluginTable) do
--   local packageName = plugin[1]:gsub('.*/', '')
--   local packageLoc = install_path .. packageName
--   if fn.empty(fn.glob(packageLoc)) > 0 then
--     isInstall = false
--     break
--   end
-- end
--
-- local function try(f, catch_f)
--   local status, exception = pcall(f)
--   if not status then
--     catch_f(exception)
--   end
-- end
--
-- if not isInstall then
--   try(function()
--     -- packer.install()
--     -- packer.sync()
--     isInstall = true
--   end, function(e)
--     print(e)
--   end)
--   -- print('Close and reopen neovim to finish installation')
--   -- vim.notify('Close and reopen neovim to finish installation')
--   -- vim.cmd('cquit')
-- end
--
-- return isInstall
