if vim.fn.has('nvim-0.9') ~= 1 then
  vim.api.nvim_echo({
    { 'Please upgrade your Neovim base installation.requires v0.9+', 'ErrorMsg' },
    { 'Press any key to continue', 'WarningMsg' },
  }, true, {})
  vim.fn.getchar()
  vim.cmd([[quit]])
end

local M = {}

M.CURRENTOS = vim.loop.os_uname().sysname
M.ISWSL = vim.fn.has('wsl') == 1 -- os.getenv('WSL_DISTRO_NAME') ~= nil

M.SETPYENV = function()
  if string.lower(M.CURRENTOS) == 'windows' or string.lower(M.CURRENTOS) == 'windows_nt' then
    local python3 =
      io.popen('Get-Command -Name python3 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue')
    if python3 then
      vim.g.python3_host_prog = python3:read()
      python3:close()
    end

    local python =
      io.popen('Get-Command -Name python -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue')
    if python then
      vim.g.python_host_prog = python:read()
      python:close()
    end
  else
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
end

--NOTE: https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
-- sudo ln -s "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" "/usr/local/bin/powershell.exe"
-- sudo ln -s "/mnt/c/Windows/System32/clip.exe" "/usr/local/bin/clip.exe"
-- sudo ln -s "/mnt/c/Windows/explorer.exe" "/usr/local/bin/open"
-- sudo ln -s "/mnt/c/Windows/System32/cmd.exe" "/usr/local/bin/cmd.exe"
-- https://github.com/iamcco/markdown-preview.nvim/issues/309

if M.CURRENTOS == 'Linux' and M.ISWSL then
  M.SETPYENV()
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      --NOTE: fix "zsh: exec format error:"
      -- https://github.com/microsoft/WSL/issues/8952#issuecomment-1568212651
      ----
      -- sudo sh -c 'echo :WSLInterop:M::MZ::/init:PF > /usr/lib/binfmt.d/WSLInterop.conf'
      -- sudo systemctl restart systemd-binfmt
      ----
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
      -- yay -S xclip
      -- ['+'] = 'xclip -selection clipboard',
      -- ['*'] = 'xclip -selection clipboard',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
  vim.opt.clipboard = 'unnamedplus'
elseif M.CURRENTOS == 'Linux' then
  M.SETPYENV()
  vim.opt.clipboard = 'unnamedplus'
elseif M.CURRENTOS == 'Darwin' then
  M.SETPYENV()
  vim.opt.clipboard = 'unnamedplus'
elseif string.lower(M.CURRENTOS) == 'windows' or string.lower(M.CURRENTOS) == 'windows_nt' then
  vim.opt.clipboard = 'unnamedplus'
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
  M.SETPYENV()
end

return M
