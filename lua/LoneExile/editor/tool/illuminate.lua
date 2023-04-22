local M = {}

M.enabled = true

M.wh_key = {
  enabled = M.enabled,
  wh_mappings = {
    u = {
      name = '+Utility',
      h = {
        name = 'highlight',
        h = {
          '<cmd>IlluminateToggle<CR>',
          'Word',
          mode = { 'n' },
        },
      },
    },
  },
}

M.setup = function()
  return {
    'RRethy/vim-illuminate',
    enabled = M.enabled,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VimEnter',
    config = function()
      local status_ok, illuminate = pcall(require, 'illuminate')
      if not status_ok then
        return
      end
      illuminate.configure({
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          'lsp',
          'treesitter',
          'regex',
        },
        -- delay: delay in milliseconds
        delay = 100,
        -- filetype_overrides: filetype specific overrides.
        -- The keys are strings to represent the filetype while the values are tables that
        -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
        filetype_overrides = {},
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
          'dirvish',
          'fugitive',
          'alpha',
        },
        -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
        filetypes_allowlist = {},
        -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
        modes_denylist = {},
        -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
        modes_allowlist = {},
        -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_denylist = {},
        -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_allowlist = {},
        -- under_cursor: whether or not to illuminate under the cursor
        under_cursor = true,
      })
    end,
  }
end

return M
