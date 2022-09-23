vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
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

      -- navic
      vim.cmd([[highlight NavicSeparator guifg=#61afef gui=bold,italic]])
      vim.cmd([[highlight NavicText guifg=#d16d9e gui=bold,italic]])

      -- diagnostics
      vim.cmd([[highlight DiagnosticVirtualTextError guifg=#db4b4b guibg=none]])

      -- Mark
      vim.cmd([[highlight MarkSignHL guifg=#61afef guibg=none gui=bold,italic]])

      -- Illuminated
      vim.cmd([[highlight IlluminatedWordText guibg=#1b1f27]])
      vim.cmd([[highlight IlluminatedWordRead guibg=#1b1f27]])
      vim.cmd([[highlight IlluminatedWordWrite guibg=#1b1f27]])
    end
  end,
})

-- 'QuickFixLine',
-- 'BufferCurrent',
-- 'ColorColumn',
-- 'TabLineFill',
-- 'TabLineSel',
-- 'TabLine',
-- 'mkdCodeDelimiter',
-- 'mkdCode',
-- '@text.literal.markdown_inline',
-- "DiffviewVertSplit",
-- "DiffviewCursorLine",
-- 'CursorLineNr',
