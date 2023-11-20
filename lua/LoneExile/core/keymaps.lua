local M = {}

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
----------------------------------------------------------

local generic_opts = {
  insert_mode = opts,
  normal_mode = opts,
  visual_mode = opts,
  visual_block_mode = opts,
  command_mode = opts,
  term_mode = { silent = true },
}

local mode_adapters = {
  insert_mode = 'i',
  normal_mode = 'n',
  term_mode = 't',
  visual_mode = 'v',
  visual_block_mode = 'x',
  command_mode = 'c',
}

local defaults = {
  insert_mode = {
    -- 'jk' for quitting insert mode
    ['jk'] = '<ESC>',
    -- 'kj' for quitting insert mode
    ['kj'] = '<ESC>',
    -- 'jj' for quitting insert mode
    ['jj'] = '<ESC>',
    -- Move current line / block with Alt-j/k ala vscode.
    ['<A-j>'] = '<Esc>:m .+1<CR>==gi',
    -- Move current line / block with Alt-j/k ala vscode.
    ['<A-k>'] = '<Esc>:m .-2<CR>==gi',
    -- navigation
    ['<A-Up>'] = '<C-\\><C-N><C-w>k',
    ['<A-Down>'] = '<C-\\><C-N><C-w>j',
    ['<A-Left>'] = '<C-\\><C-N><C-w>h',
    ['<A-Right>'] = '<C-\\><C-N><C-w>l',
  },

  normal_mode = {
    -- Better window movement
    ['<C-h>'] = '<C-w>h',
    ['<C-j>'] = '<C-w>j',
    ['<C-k>'] = '<C-w>k',
    ['<C-l>'] = '<C-w>l',

    ['<S-l>'] = ':BufferLineCycleNext<CR>',
    ['<S-h>'] = ':BufferLineCyclePrev<CR>',

    -- -- Better newline
    -- ["<Enter>"] = "o<ESC>",
    -- ["<S-Enter>"] = "O<ESC>",

    -- Resize with arrows
    ['<C-Up>'] = ':resize -2<CR>',
    ['<C-Down>'] = ':resize +2<CR>',
    ['<C-Right>'] = ':vertical resize -2<CR>',
    ['<C-Left>'] = ':vertical resize +2<CR>',

    -- Move current line / block with Alt-j/k a la vscode.
    ['<A-j>'] = ':m .+1<CR>==',
    ['<A-k>'] = ':m .-2<CR>==',

    -- QuickFix
    -- [']q'] = ':cnext<CR>',
    -- ['[q'] = ':cprev<CR>',
    -- ['<C-q>'] = ':call QuickFixToggle()<CR>',
  },

  term_mode = {
    -- Terminal window navigation
    ['<C-h>'] = '<C-\\><C-N><C-w>h',
    ['<C-j>'] = '<C-\\><C-N><C-w>j',
    ['<C-k>'] = '<C-\\><C-N><C-w>k',
    ['<C-l>'] = '<C-\\><C-N><C-w>l',
  },

  visual_mode = {
    -- Better indenting
    ['<'] = '<gv',
    ['>'] = '>gv',
    -- copy paste not copy value that changing
    ['p'] = '"0p',
    ['P'] = '"0P',
  },

  visual_block_mode = {
    -- Move selected line / block of text in visual mode
    ['K'] = ":move '<-2<CR>gv-gv",
    ['J'] = ":move '>+1<CR>gv-gv",

    -- Move current line / block with Alt-j/k ala vscode.
    ['<A-j>'] = ":m '>+1<CR>gv-gv",
    ['<A-k>'] = ":m '<-2<CR>gv-gv",
  },

  command_mode = {
    -- navigate tab completion with <c-j> and <c-k>
    -- runs conditionally
    ['<C-j>'] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
    ['<C-k>'] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
  },
}

if vim.fn.has('mac') == 1 then
  defaults.normal_mode['<A-Up>'] = defaults.normal_mode['<C-Up>']
  defaults.normal_mode['<A-Down>'] = defaults.normal_mode['<C-Down>']
  defaults.normal_mode['<A-Left>'] = defaults.normal_mode['<C-Left>']
  defaults.normal_mode['<A-Right>'] = defaults.normal_mode['<C-Right>']
  -- vim.notify('MacOS detected, remapping <A-*> to <C-*>')
  -- Log:debug("Activated mac keymappings")
end

function M.set_keymaps(mode, key, val)
  local opt = generic_opts[mode] or opts
  if type(val) == 'table' then
    opt = val[2]
    val = val[1]
  end
  if val then
    vim.keymap.set(mode, key, val, opt)
  else
    pcall(vim.api.nvim_del_keymap, mode, key)
  end
end

function M.load_mode(mode, keymaps)
  mode = mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do
    M.set_keymaps(mode, k, v)
  end
end

function M.load(keymaps)
  keymaps = keymaps or {}
  for mode, mapping in pairs(keymaps) do
    M.load_mode(mode, mapping)
  end
end

M.setup = function(root, _)
  M.load(defaults)

  -- keymap('v', 'p', '"_dP', opts) -- copy paste not copy value that changing
  keymap('t', '<C-e>', '<C-\\><C-n>', { silent = true }) -- exit insert_mode in terminal
  keymap('v', '<C-/>', '<esc>/\\%V', { noremap = true }) -- search within selection

  keymap('n', 'n', 'nzz:lua require("' .. root .. '.utils.hl_search").hl(0.01)<CR>', opts)
  keymap('n', 'N', 'Nzz:lua require("' .. root .. '.utils.hl_search").hl(0.01)<CR>', opts)

  -- mapping for i that will indent properly on empty lines:
  vim.keymap.set('x', 'i', function()
    if #vim.fn.getline('.') == 0 then
      return [["_cc]]
    else
      return 'i'
    end
  end, { expr = true })

  -- BUG: conflict with WhichKey, see `:verbose map dd`

  -- -- mapping for dd that doesn't yank an empty line into your default register
  -- function _G.dd_not_yank_empty_line()
  --   local current_line = vim.api.nvim_get_current_line()
  --   if current_line:match('^%s*$') then
  --     vim.api.nvim_command('normal! "_dd')
  --   else
  --     vim.api.nvim_command('normal! dd')
  --   end
  -- end
  -- vim.api.nvim_set_keymap('n', 'dd', ':lua _G.dd_not_yank_empty_line()<CR>', { noremap = true, silent = true })
end

------------------------------------------------------------------------------------

return M
