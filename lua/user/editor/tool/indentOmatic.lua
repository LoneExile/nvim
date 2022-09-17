local status_ok, indentOmatic = pcall(require, "indent-o-matic")
if not status_ok then
  vim.notify("indentOmatic" .. " not found!")
  return
end

indentOmatic.setup({
  -- The values indicated here are the defaults

  -- Number of lines without indentation before giving up (use -1 for infinite)
  max_lines = 2048,

  -- Space indentations that should be detected
  standard_widths = { 2, 4, 8 },

  -- Skip multi-line comments and strings (more accurate detection but less performant)
  skip_multiline = true,
})

-- This is the default configuration
require("guess-indent").setup({
  auto_cmd = true, -- Set to false to disable automatic execution
  filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
    "netrw",
    "tutor",
  },
  buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
    "help",
    "nofile",
    "terminal",
    "prompt",
  },
})
