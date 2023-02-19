local M = {}

M.setup = function(settings, _)
  return {
    'folke/tokyonight.nvim',
    priority=1000,
    config = function()
      local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. settings.theme)
      if not status_ok then
        return
      end
    end,
  }
end

return M
