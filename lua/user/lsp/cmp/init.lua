require('user.lsp.cmp.copilot')

local status_ok_lsp, lsp = pcall(require, 'lsp-zero')
if not status_ok_lsp then
  vim.notify('lsp-zero' .. ' not found!')
  return
end

local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  vim.notify('cmp' .. ' not found!')
  return
end
--
local use_icons = true
local kind = require('user.lsp.cmp.kind').icon
local keymaps = require('user.lsp.cmp.keymaps').keymaps

----- cmp config

local setting = {
  max_width = 0,
  kind_icons = kind,
  source_names = {
    copilot = '(Copilot)',
    nvim_lsp = '(LSP)',
    emoji = '(Emoji)',
    path = '(Path)',
    calc = '(Calc)',
    cmp_tabnine = '(Tabnine)',
    vsnip = '(Snippet)',
    luasnip = '(Snippet)',
    buffer = '(Buffer)',
    tmux = '(TMUX)',
  },
  duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
    luasnip = 1,
  },
  duplicates_default = 0,
  word_length = 5,
}

local cmp_config = lsp.defaults.cmp_config({
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
    { name = 'copilot', keyword_length = setting.word_length },
    { name = 'nvim_lsp', keyword_length = setting.word_length },
    { name = 'path' },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'cmp_tabnine', keyword_length = setting.word_length },
    { name = 'nvim_lua', keyword_length = setting.word_length },
    { name = 'buffer', keyword_length = setting.word_length },
    { name = 'calc' },
    { name = 'emoji' },
    { name = 'treesitter' },
    { name = 'crates' },
    { name = 'tmux' },
  },
  mapping = lsp.defaults.cmp_mappings(keymaps),
})

cmp.setup(cmp_config)

-- Add vim-dadbod-completion in sql files
-- _ = vim.cmd([[
--   augroup DadbodSql
--     au!
--     autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
--   augroup END
-- ]])
--
-- _ = vim.cmd([[
--   augroup CmpZsh
--     au!
--     autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
--   augroup END
-- ]])

--[[
" Disable cmp for a buffer
autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
--]]
