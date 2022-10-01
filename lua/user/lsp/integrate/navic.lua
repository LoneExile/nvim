local status_ok, navic = pcall(require, 'nvim-navic')
if not status_ok then
  return
end

-- TODO use utils color
local colors = {
  fg = '#bbc2cf',
  red = '#e95678',
  orange = '#FF8700',
  yellow = '#f7bb3b',
  green = '#afd700',
  cyan = '#36d0e0',
  blue = '#61afef',
  violet = '#CBA6F7',
  teal = '#1abc9c',
}

local kindIcon = {
  [1] = { 'File', ' ', colors.fg },
  [2] = { 'Module', ' ', colors.blue },
  [3] = { 'Namespace', ' ', colors.orange },
  [4] = { 'Package', ' ', colors.violet },
  [5] = { 'Class', ' ', colors.violet },
  [6] = { 'Method', ' ', colors.violet },
  [7] = { 'Property', ' ', colors.cyan },
  [8] = { 'Field', ' ', colors.teal },
  [9] = { 'Constructor', ' ', colors.blue },
  [10] = { 'Enum', '了', colors.green },
  [11] = { 'Interface', ' ', colors.orange },
  [12] = { 'Function', ' ', colors.violet },
  [13] = { 'Variable', ' ', colors.blue },
  [14] = { 'Constant', ' ', colors.cyan },
  [15] = { 'String', ' ', colors.green },
  [16] = { 'Number', ' ', colors.green },
  [17] = { 'Boolean', ' ', colors.orange },
  [18] = { 'Array', ' ', colors.blue },
  [19] = { 'Object', ' ', colors.orange },
  [20] = { 'Key', ' ', colors.red },
  [21] = { 'Null', ' ', colors.red },
  [22] = { 'EnumMember', ' ', colors.green },
  [23] = { 'Struct', ' ', colors.violet },
  [24] = { 'Event', ' ', colors.violet },
  [25] = { 'Operator', ' ', colors.green },
  [26] = { 'TypeParameter', ' ', colors.green },
  -- ccls
  [252] = { 'TypeAlias', ' ', colors.green },
  [253] = { 'Parameter', ' ', colors.blue },
  [254] = { 'StaticMethod', 'ﴂ ', colors.orange },
  [255] = { 'Macro', ' ', colors.red },
}

local iconTable = {}

for _, v in ipairs(kindIcon) do
  iconTable[v[1]] = v[2]
end

navic.setup({
  icon = iconTable,
  highlight = true,
  separator = ' >> ',
  depth_limit = 0,
  depth_limit_indicator = '..',
})

local kind = kindIcon
local prefix = 'NavicIcons'
local group = vim.api.nvim_create_augroup('transparencyTheme', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    for _, v in pairs(kind) do
      vim.api.nvim_set_hl(0, prefix .. v[1], { fg = v[3], italic = true })
    end
  end,
  group = group,
})
