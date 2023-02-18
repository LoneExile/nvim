-- vim.g.catppuccin_flavour = 'mocha' -- latte, frappe, macchiato, mocha
-- require('catppuccin').setup()
-- vim.api.nvim_command('colorscheme catppuccin')

local colorscheme = 'tokyonight-storm' -- "tokyonight-storm" -- "duskfox" -- "carbonfox" -- "onedarker"
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
  return
end
