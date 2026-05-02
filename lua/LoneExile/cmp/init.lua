local M = {}

-- blink.cmp migration (2026-05-02):
--   * Replaces nvim-cmp + cmp-buffer + cmp-path + cmp-nvim-lsp + cmp-nvim-lua
--     + cmp_luasnip with a single Rust-backed completion engine.
--   * Drops cmp-tw2css (no blink equivalent — Tailwind LSP still gives class
--     completions; for inline color preview see `luckasRanarison/tailwind-tools.nvim`).
--   * Drops cmp-dotenv (no blink port).
--   * Copilot intentionally NOT added as a completion source — ghost-text via
--     copilot.lua suggestions is the sole UX (user preference).
--   * `lsp/init.lua` now sources capabilities from blink instead of cmp_nvim_lsp.
--   * nvim-autopairs cmp_autopairs.on_confirm_done hook removed; modern
--     nvim-autopairs auto-detects blink and integrates without it.

M.setup = function(settings, location)
  return {
    'Saghen/blink.cmp',
    event = 'InsertEnter',
    version = '1.*', -- prebuilt fuzzy matcher binary
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        event = 'InsertCharPre',
        dependencies = { 'rafamadriz/friendly-snippets' },
        config = function()
          local ok, luasnip = pcall(require, 'luasnip')
          if not ok then return end
          require(location .. '.luasnip').setup_luasnip(luasnip)
        end,
      },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' preset: <C-y> accept, <C-Space> show, <C-e> cancel,
      -- <C-d>/<C-f> scroll docs. <CR> is intentionally NOT mapped (falls
      -- through to insert a literal newline — user's existing behavior).
      keymap = {
        preset = 'default',
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'snippet_forward', 'fallback' },
        ['<C-k>'] = { 'snippet_backward', 'fallback' },
      },

      appearance = {
        -- Reuse the existing kind icon table (same shape as blink expects:
        -- { Function = '', Method = '', ... }).
        kind_icons = settings.utils.convert_kind_icons(settings.kindIcon),
      },

      snippets = { preset = 'luasnip' },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        menu = { border = 'rounded' },
        ghost_text = { enabled = false },
      },

      signature = { enabled = true, window = { border = 'rounded' } },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
        providers = {
          -- lazydev: mirror the previous group_index = 0 behavior so its
          -- Lua API completions take priority over LuaLS workspace results.
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
          -- blink ships a built-in Tailwind hack at
          -- `blink.cmp.sources.lsp.hacks.tailwind` that runs automatically
          -- when client.name == 'tailwindcss'. It detects color items
          -- (kind=Color + 7-char #RRGGBB documentation) and rewrites
          -- `item.kind_icon` to the configured icon and `item.kind_hl` to
          -- a `HexColor<rgb>` group with `fg = #<rgb>`. The default icon
          -- is '██' — bumping the size makes the color more readable.
          lsp = { opts = { tailwind_color_icon = '██' } },
        },
      },

      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  }
end

return M
