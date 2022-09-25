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
-- local _, cmp = pcall(require, 'cmp')
local _, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
local _, handlers = pcall(require, 'nvim-autopairs.completion.handlers')
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
--------------------------------------------------

local jumpable = require('user.lsp.cmp.utils').jumpable
local has_words_before = require('user.lsp.cmp.utils').has_words_before
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local confirmOpts = {
  behavior = cmp.ConfirmBehavior.Replace,
  select = false,
}

M.keymaps = {
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
  ['<Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() and has_words_before() then
      -- if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_locally_jumpable() then
      luasnip.expand_or_jump()
    elseif jumpable(1) then
      luasnip.jump(1)
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { 'i', 's' }),
  ['<S-Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { 'i', 's' }),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  -- ["<CR>"] = cmp.mapping(function(fallback)
  -- 	if cmp.visible() then
  -- 		local confirm_opts = confirmOpts
  -- 		local is_insert_mode = function()
  -- 			return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
  -- 		end
  -- 		if is_insert_mode() then -- prevent overwriting brackets
  -- 			confirm_opts.behavior = cmp.ConfirmBehavior.Insert
  -- 		end
  -- 		cmp.confirm(confirm_opts)
  -- 		if jumpable(1) then
  -- 			luasnip.jump(1)
  -- 		end
  -- 		return
  -- 	end
  --
  -- 	if jumpable(1) then
  -- 		if not luasnip.jump(1) then
  -- 			fallback()
  -- 		end
  -- 	else
  -- 		fallback()
  -- 	end
  -- end),
}

return M
