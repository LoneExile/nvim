local M = {}

M.setup = function(settings, location)
  return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'saadparwaiz1/cmp_luasnip', dependencies = { 'L3MON4D3/LuaSnip', event = 'InsertCharPre' } },
      { 'rafamadriz/friendly-snippets' },
      { 'jcha0713/cmp-tw2css' },
      { 'windwp/nvim-autopairs', dependencies = { 'nvim-treesitter/nvim-treesitter' }, event = 'InsertEnter' },
    },
    config = function()
      local cmp_ok, cmp = pcall(require, 'cmp')
      if not cmp_ok then
        return
      end
      local luasnip_ok, luasnip = pcall(require, 'luasnip')
      if not luasnip_ok then
        return
      end
      require(location .. '.luasnip').setup_luasnip(luasnip)

      local use_icons = true
      local kind = settings.utils.convert_kind_icons(settings.kindIcon)

      local keymaps = require(location .. '.keymaps').keymaps(cmp, luasnip, settings)

      ----- cmp config
      local setting = {
        max_width = 0,
        kind_icons = kind,
        source_names = {
          ['cmp-tw2css'] = '(CSS)',
          copilot = '(Copilot)',
          nvim_lsp = '(LSP)',
          -- emoji = '(Emoji)',
          path = '(Path)',
          -- calc = '(Calc)',
          -- cmp_tabnine = '(Tabnine)',
          vsnip = '(Snippet)',
          luasnip = '(Snippet)',
          buffer = '(Buffer)',
          -- tmux = '(TMUX)',
        },
        duplicates = {
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
          luasnip = 1,
        },
        duplicates_default = 0,
      }

      local cmp_config = {
        completion = {
          keyword_length = 1,
        },
        experimental = {
          ghost_text = false,
          native_menu = false,
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item)
            local max_width = setting.max_width
            if max_width ~= 0 and #vim_item.abbr > max_width then
              vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. '…'
            end
            if use_icons then
              vim_item.kind = setting.kind_icons[vim_item.kind]
            end
            if entry.source.name == 'copilot' then
              vim_item.kind = ' '
              vim_item.kind_hl_group = 'CmpItemKindCopilot'
            end

            -- get color highlight on tailwindcss
            if vim_item.kind == kind['Color'] and entry.completion_item.documentation then
              local blackOrWhiteFg = function(r, g, b)
                return ((r * 0.299 + g * 0.587 + b * 0.114) > 186) and '#000000' or '#ffffff'
              end
              local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
              if r then
                local color = string.format('%02x', r) .. string.format('%02x', g) .. string.format('%02x', b)
                print(color)
                local group = 'Tw_' .. color
                if vim.fn.hlID(group) < 1 then
                  vim.api.nvim_set_hl(0, group, { fg = blackOrWhiteFg(r, g, b), bg = '#' .. color })
                end

                vim_item.kind = kind['Color']
                -- vim_item.kind_hl_group = group -- get hl to icon
                vim_item.abbr_hl_group = group
              end
            end

            vim_item.menu = setting.source_names[entry.source.name]
            vim_item.dup = setting.duplicates[entry.source.name] or setting.duplicates_default
            return vim_item
          end,
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = 'copilot' },
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'luasnip' },
          -- { name = 'cmp_tabnine'},
          { name = 'nvim_lua' },
          { name = 'cmp-tw2css' },
          { name = 'buffer', max_item_count = 5 },
          -- { name = 'calc' },
          -- { name = 'emoji' },
          -- { name = 'treesitter' },
          { name = 'crates' },
          -- { name = 'tmux' },
          { name = 'lazydev', group_index = 0 }, -- set group index to 0 to skip loading LuaLS completions
        },
        mapping = keymaps,
      }
      cmp.setup(cmp_config)
    end,
  }
end

return M
