local status_ok, indentOmatic = pcall(require, 'indent-o-matic')
if not status_ok then
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
