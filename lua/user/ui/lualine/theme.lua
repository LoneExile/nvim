local M = {}

M.theme = function(colors)
  return {
    inactive = {
      a = { fg = colors.blue, bg = colors.nobg, gui = 'bold' },
      b = { bg = colors.nobg, gui = 'bold' },
      c = { bg = colors.nobg },
      x = { bg = colors.nobg },
      y = { bg = colors.nobg },
      z = { fg = colors.blue, bg = colors.nobg, gui = 'bold' },
    },
    visual = {
      a = { fg = colors.black, bg = colors.mauve, gui = 'bold' },
      b = { bg = colors.nobg, gui = 'bold' },
      c = { bg = colors.nobg },
      x = { bg = colors.nobg },
      y = { bg = colors.nobg },
      z = { fg = colors.black, bg = colors.mauve, gui = 'bold' },
    },
    replace = {
      a = { fg = colors.black, bg = colors.red, gui = 'bold' },
      b = { bg = colors.nobg, gui = 'bold' },
      c = { bg = colors.nobg },
      x = { bg = colors.nobg },
      y = { bg = colors.nobg },
      z = { fg = colors.black, bg = colors.red, gui = 'bold' },
    },
    normal = {
      a = { fg = colors.white, bg = colors.buleish, gui = 'bold' },
      b = { bg = colors.nobg, gui = 'bold' },
      c = { bg = colors.nobg },
      x = { bg = colors.nobg },
      y = { bg = colors.nobg },
      z = { fg = colors.white, bg = colors.buleish, gui = 'bold' },
    },
    insert = {
      a = { fg = colors.black, bg = colors.light_green, gui = 'bold' },
      b = { bg = colors.nobg, gui = 'bold' },
      c = { bg = colors.nobg },
      x = { bg = colors.nobg },
      y = { bg = colors.nobg },
      z = { fg = colors.black, bg = colors.light_green, gui = 'bold' },
    },
    command = {
      a = { fg = colors.black, bg = colors.peach, gui = 'bold' },
      b = { bg = colors.nobg, gui = 'bold' },
      c = { bg = colors.nobg },
      x = { bg = colors.nobg },
      y = { bg = colors.nobg },
      z = { fg = colors.black, bg = colors.peach, gui = 'bold' },
    },
  }
end
return M
