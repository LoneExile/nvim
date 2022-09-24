if vim.fn.has('nvim-0.7') ~= 1 then
  print('Please upgrade your Neovim base installation.requires v0.8+')
  vim.wait(5000, function()
    return false
  end)
  vim.cmd('cquit')
end

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
