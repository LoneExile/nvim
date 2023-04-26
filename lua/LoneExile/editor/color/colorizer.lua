local M = {}

M.setup = function()
  return {
    'nvchad/nvim-colorizer.lua',
    event = { 'BufReadPre', 'InsertEnter' },
    config = function()
      local status_ok, colorizer = pcall(require, 'colorizer')
      if not status_ok then
        return
      end

      local config = {
        filetypes = { '*' },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = true, -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = true, -- 0xAARRGGBB hex codes
          rgb_fn = false, -- CSS rgb() and rgba() functions
          hsl_fn = false, -- CSS hsl() and hsla() functions
          css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = 'background', -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = true, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          -- sass = { enable = false, parsers = { css } }, -- Enable sass colors
          virtualtext = '■',
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
      }

      colorizer.setup(config)

      local group = vim.api.nvim_create_augroup('colorAttach', { clear = true })
      local events = { 'BufEnter', 'BufWinEnter', 'CursorMoved' }
      vim.api.nvim_create_autocmd(events, {
        pattern = { '*' },
        callback = function()
          vim.cmd([[
          if exists('g:colorizer')
             ColorizerAttachToBuffer
          ]])
        end,
        group = group,
      })
    end,
  }
end

return M
