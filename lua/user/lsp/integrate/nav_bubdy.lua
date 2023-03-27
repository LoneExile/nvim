local M = {}

M.enabled = false

M.setup = function(_, _)
  return {
    'SmiteshP/nvim-navbuddy',
    enabled = M.enabled,
    dependencies = { 'neovim/nvim-lspconfig', 'SmiteshP/nvim-navic', 'MunifTanjim/nui.nvim' },
    config = function()
      local status_ok, navbuddy = pcall(require, 'nvim-navbuddy')
      if not status_ok then
        print('Error loading nvim-navbuddy')
        return
      end
      navbuddy.setup({})
    end,
  }
end

-- on_attach = function(client, bufnr)
--   local status_navbuddy, navbuddy = pcall(require, 'nvim-nvim-navbuddy')
--   if status_navbuddy then
--     navbuddy.attach(client, bufnr)
--   end
-- end,

return M
