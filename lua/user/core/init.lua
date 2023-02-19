require('user.core.optimize')
require('user.core.options')
require('user.core.keymaps')
require('user.core.lazy')
require('user.core.autoCmd')

local hl_groups = {
  'BufferLineTabClose',
  'BufferlineBufferSelected',
  'BufferLineFill',
  'BufferLineBackground',
  'BufferLineSeparator',
  'BufferLineIndicatorSelected',
  'BufferLineDevIconDefault',
  'Normal',
  'SignColumn',
  'NormalNC',
  'TelescopeBorder',
  'NvimTreeNormal',
  'EndOfBuffer',
  'MsgArea',
  'WhichKeyFloat',
  'FloatBorder',
  'NormalFloat',
  'VertSplit',
  'WinBar',
  'StatusLine',
  'StatusLineNC',
  'WinBarNC',
  'TelescopeNormal',
  'DiffviewNormal',
  --
  'LspReferenceText',
  'LspReferenceRead',
  'LspReferenceText',
  'LspFloatWinNormal',
  'LspReferenceWrite',
  'CmpDocumentation',
  'NormalSB', -- help tag
  'SignColumnSB', -- help tag
}
for _, name in ipairs(hl_groups) do
  vim.cmd(string.format('highlight %s ctermbg=none guibg=none', name))
end

vim.cmd([[highlight TreesitterContext ctermbg=none guibg=none gui=bold]])
vim.cmd([[highlight IndentBlanklineContextChar guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineSpaceChar guifg=#5c6370 gui=nocombine]])

-- copilot
vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })

-- neotree
vim.cmd([[highlight NeoTreeNormal ctermbg=none guibg=none guifg=#f2f4f8 ]])
vim.cmd([[highlight NeoTreeNormalNC ctermbg=none guibg=none guifg=#a9b1d6 ]])
vim.cmd([[highlight NeoTreeGitModified guifg=#c678dd]])
vim.cmd([[highlight NeoTreeGitConflict gui=bold guifg=#e46876]])
vim.cmd([[highlight NeoTreeGitUntracked guifg=#c678dd]])

-- PanelHeading bufferline
vim.cmd([[highlight PanelHeading ctermbg=none guibg=none gui=bold,italic guifg=#777777]])
vim.cmd([[highlight NeoTreeTabInactive guifg=#777777 guibg=none]])
vim.cmd([[highlight NeoTreeTabActive guibg=#141414 gui=bold,italic]])
vim.cmd([[highlight NeoTreeTabSeparatorInactive guifg=#777777 guibg=none]])

-- diagnostics
vim.cmd([[highlight DiagnosticVirtualTextError guifg=#db4b4b guibg=none]])

-- Mark
vim.cmd([[highlight MarkSignHL guifg=#61afef guibg=none gui=bold,italic]])

-- navic
vim.cmd([[highlight NavicSeparator guifg=#61afef gui=bold,italic]])
vim.cmd([[highlight NavicText guifg=#d16d9e gui=bold,italic]])

-- DiffText
vim.cmd([[highlight DiffText guibg=#F4F4F4]])
vim.cmd([[highlight DiffChange guibg=none]])
vim.cmd([[highlight diffChanged guibg=none]])
-- vim.cmd([[highlight BufferCurrentSign guifg=#0db9d7 guibg=none]])

-- MatchUp
vim.cmd([[highlight MatchParen guifg=#FFD700 gui=bold]])
vim.cmd([[highlight MatchParenCur guifg=none gui=bold]])
vim.cmd([[highlight MatchWordCur guifg=none gui=bold]])

-- Illuminated
vim.cmd([[highlight IlluminatedWordText guibg=none gui=bold]])
vim.cmd([[highlight IlluminatedWordRead guibg=none gui=bold]])
vim.cmd([[highlight IlluminatedWordWrite guibg=none gui=bold]])

-- Notify
vim.cmd([[highlight NotifyINFOBody guifg=#c0caf5 guibg=none]])
vim.cmd([[highlight NotifyINFOBorder guifg=#1d546a guibg=none]])
vim.cmd([[highlight NotifyERRORBody guifg=#c0caf5 guibg=none]])
vim.cmd([[highlight NotifyERRORBorder guifg=#5b3340 guibg=none]])
vim.cmd([[highlight NotifyWARNBody guifg=#c0caf5 guibg=none]])
vim.cmd([[highlight NotifyWARNBorder guifg=#5c5149 guibg=none]])
vim.cmd([[highlight NotifyDEBUGBody guifg=#c0caf5 guibg=none]])
vim.cmd([[highlight NotifyDEBUGBorder guifg=#3b4252 guibg=none]])
vim.cmd([[highlight NotifyTRACEBody guifg=#c0caf5 guibg=none]])
vim.cmd([[highlight NotifyTRACEBorder guifg=#48416a guibg=none]])
