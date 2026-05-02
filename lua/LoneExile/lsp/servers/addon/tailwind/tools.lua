local M = {}

-- LoneExile/tailwind-tools.nvim
--   Fork of luckasRanarison/tailwind-tools.nvim (archived 2026-04-25).
--   Forked 2026-05-02 to add a blink.cmp integration alongside the upstream
--   nvim-cmp/lspkind one (we migrated to blink and the upstream is no longer
--   accepting PRs). See lua/tailwind-tools/blink.lua in the fork.
--
-- Loads on the typical Tailwind-bearing filetypes. The Tailwind LSP
-- (mason package: tailwindcss-language-server) must be installed for the
-- LSP-driven features (color preview, conceal class lookup) to work.

M.setup = function()
  return {
    'LoneExile/tailwind-tools.nvim',
    ft = {
      'html',
      'css',
      'scss',
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
      'svelte',
      'astro',
      'templ',
      'heex',
      'elixir',
      'phoenix_heex',
    },
    cmd = {
      'TailwindConcealEnable',
      'TailwindConcealDisable',
      'TailwindConcealToggle',
      'TailwindColorEnable',
      'TailwindColorDisable',
      'TailwindColorToggle',
      'TailwindSort',
      'TailwindSortSelection',
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-lua/plenary.nvim',
    },
    opts = {
      -- Don't let tailwind-tools call lspconfig.tailwindcss.setup() —
      -- our `lsp/tailwindcss.lua` already configures the server via the
      -- modern `vim.lsp.config()` runtime path. With override=true the
      -- plugin's setup() goes through `require('lspconfig')` and triggers
      -- the deprecation warning ("framework is deprecated, use
      -- vim.lsp.config"). All non-server features (color request, conceal,
      -- sort) hook in via an LspAttach autocmd that runs regardless.
      server = { override = false, settings = {} },
      document_color = {
        enabled = true,
        kind = 'inline', -- inline | foreground | background
        inline_symbol = '󰝤 ',
        debounce = 200,
      },
      conceal = {
        -- Off by default; toggle with :TailwindConcealToggle when classes
        -- get visually overwhelming in deeply-nested JSX.
        enabled = false,
        min_length = nil,
        symbol = '󱏿',
        highlight = { fg = '#38BDF8' },
      },
      cmp = {
        -- Foreground keeps the icon readable; switch to "background" if you
        -- prefer a color-swatch look. Applies to BOTH cmp engines (the fork
        -- reuses this option for the blink integration).
        highlight = 'foreground',
      },
    },
  }
end

return M
