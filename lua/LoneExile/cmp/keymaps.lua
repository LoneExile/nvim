local M = {}

--------------------------------------------------

M.keymaps = function(cmp, luasnip, _) -- settings
  --------------------------------------------------
  -- https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
  local status_cmp, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
  local status_handlers, handlers = pcall(require, 'nvim-autopairs.completion.handlers')
  if status_cmp and status_handlers then
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done({
        filetypes = {
          -- "*" is a alias to all filetypes
          ['*'] = {
            ['('] = {
              kind = {
                cmp.lsp.CompletionItemKind.Function,
                cmp.lsp.CompletionItemKind.Method,
              },
              handler = handlers['*'],
            },
          },
        },
      })
    )
  end
  --------------------------------------------------
  -- local jumpable = require(settings.root .. '.cmp.utils').jumpable
  -- local has_words_before = require(settings.root .. '.cmp.utils').has_words_before
  local cmp_select = { behavior = cmp.SelectBehavior.Select }

  -- local confirmOpts = {
  --   behavior = cmp.ConfirmBehavior.Replace,
  --   select = false,
  -- }
  --------------------------------------------------
  return {
    -- ["<C-k>"] = cmp.mapping.select_prev_item(),
    -- ["<C-j>"] = cmp.mapping.select_next_item(),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ cmp_select }), { 'i' }),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ cmp_select }), { 'i' }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-y>'] = cmp.mapping({
      i = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
      c = function(fallback)
        if cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
    }),
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() and has_words_before() then
    --     -- if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_locally_jumpable() then
    --     luasnip.expand_or_jump()
    --   elseif jumpable(1) then
    --     luasnip.jump(1)
    --   elseif has_words_before() then
    --     cmp.complete()
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping(function(fallback)
      fallback()
      -- if cmp.visible() then
      --   local confirm_opts = confirmOpts
      --   local is_insert_mode = function()
      --     return vim.api.nvim_get_mode().mode:sub(1, 1) == 'i'
      --   end
      --   if is_insert_mode() then -- prevent overwriting brackets
      --     confirm_opts.behavior = cmp.ConfirmBehavior.Insert
      --   end
      --   cmp.confirm(confirm_opts)
      --   if jumpable(1) then
      --     luasnip.jump(1)
      --   end
      --   return
      -- end
      -- -- local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
      -- -- vim.cmd(line .. ',s/.$//')
      --
      -- if jumpable(1) then
      --   if not luasnip.jump(1) then
      --     fallback()
      --   end
      -- else
      --   fallback()
      -- end
    end),
  }
end

return M
