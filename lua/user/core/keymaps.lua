local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('v', 'p', '"_dP', { noremap = true, silent = true }) -- copy paste not copy value that changing
keymap('t', '<C-e>', '<C-\\><C-n>', { silent = true }) -- exit insert_mode in terminal

----------------------------------------------------------
local M = {}

local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
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
    [']q'] = ':cnext<CR>',
    ['[q'] = ':cprev<CR>',
    ['<C-q>'] = ':call QuickFixToggle()<CR>',
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

    -- ["p"] = '"0p',
    -- ["P"] = '"0P',
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
  vim.notify('MacOS detected, remapping <A-*> to <C-*>')
  -- Log:debug("Activated mac keymappings")
end

function M.clear(keymaps)
  local default = M.get_defaults()
  for mode, mappings in pairs(keymaps) do
    local translated_mode = mode_adapters[mode] and mode_adapters[mode] or mode
    for key, _ in pairs(mappings) do
      -- some plugins may override default bindings that the user hasn't manually overriden
      if default[mode][key] ~= nil or (default[translated_mode] ~= nil and default[translated_mode][key] ~= nil) then
        pcall(vim.api.nvim_del_keymap, translated_mode, key)
        -- pcall(vim.keymap.del, translated_mode, key)
      end
    end
  end
end

function M.set_keymaps(mode, key, val)
  local opt = generic_opts[mode] or generic_opts_any
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

function M.load_defaults()
  M.load(M.get_defaults())
end

-- Get the default keymappings
function M.get_defaults()
  return defaults
end

return M
