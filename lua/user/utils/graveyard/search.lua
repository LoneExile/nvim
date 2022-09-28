require('hlslens').setup({
  override_lens = function(render, posList, nearest, idx, relIdx)
    local sfw = vim.v.searchforward == 1
    local indicator, text, chunks
    local absRelIdx = math.abs(relIdx)
    if absRelIdx > 1 then
      indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
    elseif absRelIdx == 1 then
      indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
    else
      indicator = ''
    end

    local lnum, col = unpack(posList[idx])
    if nearest then
      local cnt = #posList
      if indicator ~= '' then
        text = ('[%s %d/%d]'):format(indicator, idx, cnt)
      else
        text = ('[%d/%d]'):format(idx, cnt)
      end
      chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
    else
      text = ('[%s %d]'):format(indicator, idx)
      chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
    end
    render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
  end,
})
-----------------------------------------------------------------------------

local kopts = { noremap = true, silent = true }
local hlslens = '<Cmd>lua require("hlslens").start()<CR>'
local keymap = vim.api.nvim_set_keymap

keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR>]] .. hlslens, kopts)
keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR>]] .. hlslens, kopts)
keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

-- Search
vim.cmd([[highlight HlSearchLens guifg=#292e42 guibg=none gui=none]])
vim.cmd([[highlight HlSearchLensNear guifg=#ff9e64 guibg=none gui=none]])
vim.cmd([[highlight HlSearchFloat guifg=#ff9e64 guibg=none gui=none]])
vim.cmd([[highlight HlSearchNear guifg=#ff9e64 guibg=none gui=none]])
