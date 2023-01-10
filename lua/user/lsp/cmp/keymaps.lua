local M = {}

local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  vim.notify('cmp' .. ' not found!')
  return
end

local luasnip_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_ok then
  vim.notify('luasnip' .. ' not found!')
  return
end
require('user.lsp.cmp.luasnip')

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

local jumpable = require('user.lsp.cmp.utils').jumpable
local has_words_before = require('user.lsp.cmp.utils').has_words_before
local cmp_select = { behavior = cmp.SelectBehavior.Select }

M.keymaps = {
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
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping(function(fallback)
    fallback()
  end),
}

return M
