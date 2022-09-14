local api = vim.api

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

-------------------------------------------------------------

-- local group = vim.api.nvim_create_augroup("transparencyTheme", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local hl_groups = {
      "BufferLineTabClose",
      "BufferlineBufferSelected",
      "BufferLineFill",
      "BufferLineBackground",
      "BufferLineSeparator",
      "BufferLineIndicatorSelected",
      "BufferLineDevIconDefault",
      "Normal",
      "SignColumn",
      "NormalNC",
      "TelescopeBorder",
      "NvimTreeNormal",
      "EndOfBuffer",
      "MsgArea",
      "WhichKeyFloat",
      "FloatBorder",
      "NormalFloat",
      "VertSplit",
      "WinBar",
      "StatusLine",
      "StatusLineNC",
      "WinBarNC",
      "TelescopeNormal",
    }
    for _, name in ipairs(hl_groups) do
      vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
      vim.cmd([[highlight TreesitterContext ctermbg=none guibg=none gui=bold]])
      vim.cmd([[highlight NeoTreeNormal ctermbg=none guibg=none guifg=#f2f4f8 ]])
      vim.cmd([[highlight IndentBlanklineContextChar guifg=#61AFEF gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineSpaceChar guifg=#5c6370 gui=nocombine]])
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    end
  end,
  -- group = group,
})
