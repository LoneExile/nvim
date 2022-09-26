local status_ok_code, surround = pcall(require, 'mini.surround')
if not status_ok_code then
  return
end

surround.setup({
  -- Add custom surroundings to be used on top of builtin ones. For more
  -- information with examples, see `:h MiniSurround.config`.
  custom_surroundings = nil,

  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 500,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = 'sa', -- Add surrounding in Normal and Visual modes
    delete = 'sd', -- Delete surrounding
    find = 'sf', -- Find surrounding (to the right)
    find_left = 'sF', -- Find surrounding (to the left)
    highlight = 'sh', -- Highlight surrounding
    replace = 'sr', -- Replace surrounding
    update_n_lines = 'sn', -- Update `n_lines`

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  },

  -- Number of lines within which surrounding is searched
  n_lines = 20,

  -- How to search for surrounding (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
  -- see `:h MiniSurround.config`.
  search_method = 'cover',
})

-- local status_ok, jump2d = pcall(require, 'mini.jump2d')
-- if not status_ok then
--   return
-- end

-- jump2d.setup({
--   -- Function producing jump spots (byte indexed) for a particular line.
--   -- For more information see |MiniJump2d.start|.
--   -- If `nil` (default) - use |MiniJump2d.default_spotter|
--   spotter = nil,
--
--   -- Characters used for labels of jump spots (in supplied order)
--   labels = 'abcdefghijklmnopqrstuvwxyz',
--
--   -- Which lines are used for computing spots
--   allowed_lines = {
--     blank = true, -- Blank line (not sent to spotter even if `true`)
--     cursor_before = true, -- Lines before cursor line
--     cursor_at = true, -- Cursor line
--     cursor_after = true, -- Lines after cursor line
--     fold = true, -- Start of fold (not sent to spotter even if `true`)
--   },
--
--   -- Which windows from current tabpage are used for visible lines
--   allowed_windows = {
--     current = true,
--     not_current = true,
--   },
--
--   -- Functions to be executed at certain events
--   hooks = {
--     before_start = nil, -- Before jump start
--     after_jump = nil, -- After jump was actually done
--   },
--
--   -- Module mappings. Use `''` (empty string) to disable one.
--   mappings = {
--     start_jumping = 'gh',
--   },
-- })
