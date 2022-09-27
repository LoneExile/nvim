local status_ok, autopairs = pcall(require, 'nvim-autopairs')
if not status_ok then
  vim.notify('nvim-autopairs not installed', vim.log.levels.ERROR)
  return
end

---------------------------------------------------------------------------------------
local M = {}

M.configs = {
  active = true,
  on_config_done = nil,
  map_char = {
    all = '(',
    tex = '{',
  },
  enable_check_bracket_line = false,
  check_ts = true,
  ts_config = {
    lua = { 'string', 'source' },
    javascript = { 'string', 'template_string' },
    java = false,
  },
  disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
  enable_moveright = true,
  disable_in_macro = false,
  enable_afterquote = true,
  map_bs = true,
  map_c_w = false,
  disable_in_visualblock = false,
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    offset = 0, -- Offset from pattern match
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey = 'Comment',
  },
}

-- local _, autopairs = pcall(require, 'nvim-autopairs')
-- local _, Rule = pcall(require, 'nvim-autopairs.rule')
-- local _, treesitter = pcall(require, 'nvim-treesitter.configs')
-- local _, ts_conds = pcall(require, 'nvim-autopairs.ts-conds')
--
M.setup = function()
  -- local autopairs = require('nvim-autopairs')
  -- local Rule = require('nvim-autopairs.rule')

  autopairs.setup(M.configs)

  -- require('nvim-treesitter.configs').setup({ autopairs = { enable = true } })

  -- local ts_conds = require('nvim-autopairs.ts-conds')

  -- -- press % => %% is only inside comment or string
  -- autopairs.add_rules({
  --   Rule('%', '%', 'lua'):with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
  --   Rule('$', '$', 'lua'):with_pair(ts_conds.is_not_ts_node({ 'function' })),
  -- })
  --
end

return M.setup()
