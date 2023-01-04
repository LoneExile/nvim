-- https://github.com/akinsho/toggleterm.nvim#custom-terminal-usage
local terminal = require('user.editor.coding.toggleterm').terminal

-- TODO: check is command is available before mapping
terminal.execs = {
  { 'lazygit', '<leader>gg', 'LazyGit', 'float' },
  { 'lazygit', '<leader>tg', 'LazyGit', 'float' },
}

local linux = {
  {
    'nnn -er',
    '<leader>tn',
    'nnn',
    'float',
  },
  {
    'btop',
    '<leader>tt',
    'btop',
    'float',
  },
  {
    'bash ' .. vim.fn.stdpath('config') .. '/scripts/cht/cht.sh',
    '<leader>tc',
    'cheet sheet',
    'float',
  },
}

local CURRENTOS = require('user.utils.requirements').CURRENTOS
if CURRENTOS == 'Linux' or CURRENTOS == 'Darwin' then
  for _, v in ipairs(linux) do
    table.insert(terminal.execs, v)
  end
end
