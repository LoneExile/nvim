local M = {}

M.setup = function(settings, location)
  -- print(location)
  return {
    'nvim-lualine/lualine.nvim',
    config = function()
      local status_ok, lualine = pcall(require, 'lualine')
      if not status_ok then
        return
      end
      vim.schedule(function()
        -- vim.cmd([[lua vim.o.ls=1]]) -- enable statusline
        local components = require(location .. '.components').setup(settings, location)
        local theme = require(location .. '.theme').theme(settings.colors)
        lualine.setup({
          options = {
            icons_enabled = true,
            theme = theme,
            component_separators = '',
            section_separators = { left = '', right = '' },
            disabled_filetypes = { 'alpha', 'Outline' },
            always_divide_middle = true,
            globalstatus = true,
          },
          sections = {
            lualine_a = { 'mode' },
            lualine_b = { components.filename },
            lualine_c = { '' },
            lualine_x = {},
            lualine_y = {
              components.treesitter,
              components.lsp,
              components.diagnostics,
              components.diff,
              components.branch,
              components.filetype,
            },
            lualine_z = { 'progress' },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
          },
          tabline = {},
          extensions = { 'neo-tree', 'nerdtree', 'nvim-dap-ui', 'toggleterm' },
        })
      end)
    end,
  }
end

return M
