local M = {}

M.wh_key = {
  wh_mappings = {
    u = {
      name = '+Utility',
      c = {
        name = '+Color picker',
        p = {
          '<cmd>Colortils picker<cr>',
          'picker',
          mode = { 'n' },
        },
        l = {
          '<cmd>Colortils lighten<cr>',
          'lighten',
          mode = { 'n' },
        },
        d = {
          '<cmd>Colortils darken<cr>',
          'darken',
          mode = { 'n' },
        },
        s = {
          '<cmd>Colortils greyscale<cr>',
          'greyscale',
          mode = { 'n' },
        },
        g = {
          '<cmd>Colortils gradient<cr>',
          'gradient',
          mode = { 'n' },
        },
        L = { '<cmd>Colortils css list<cr>', 'List', mode = { 'n' } },
      },
    },
  },
}

M.setup = function()
  return {
    'max397574/colortils.nvim',
    config = function()
      local status_ok_code, colortils = pcall(require, 'colortils')
      if not status_ok_code then
        return
      end

      local configs = {
        -- Register in which color codes will be copied
        register = '+',
        -- Preview for colors, if it contains `%s` this will be replaced with a hex color code of the color
        color_preview = '█ %s',
        -- The default in which colors should be saved
        -- This can be hex, hsl or rgb
        default_format = 'hex',
        -- Border for the float
        border = 'rounded',
        -- Some mappings which are used inside the tools
        mappings = {
          -- increment values
          increment = 'l',
          -- decrement values
          decrement = 'h',
          -- increment values with bigger steps
          increment_big = 'L',
          -- decrement values with bigger steps
          decrement_big = 'H',
          -- set values to the minimum
          min_value = '0',
          -- set values to the maximum
          max_value = '$',
          -- save the current color in the register specified above with the format specified above
          set_register_default_format = '<cr>',
          -- save the current color in the register specified above with a format you can choose
          set_register_cjoose_format = 'g<cr>',
          -- replace the color under the cursor with the current color in the format specified above
          replace_default_format = '<m-cr>',
          -- replace the color under the cursor with the current color in a format you can choose
          replace_choose_format = 'g<m-cr>',
          -- export the current color to a different tool
          export = 'E',
          -- set the value to a certain number (done by just entering numbers)
          set_value = 'c',
          -- toggle transparency
          transparency = 'T',
          -- choose the background (for transparent colors)
          choose_background = 'B',
        },
      }

      colortils.setup(configs)
    end,
  }
end

return M
