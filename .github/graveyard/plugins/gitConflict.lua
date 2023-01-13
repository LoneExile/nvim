-- { "akinsho/git-conflict.nvim", tag = "*" },
-- { "https://gitlab.com/yorickpeterse/nvim-pqf", as = "nvim-pqf" },

local status_ok_ui, gitConflict = pcall(require, 'git-conflict')
if not status_ok_ui then
  vim.notify('git-conflict' .. ' not found!')
  return
end

-- local opts = { noremap = true, silent = true }
-- local keymap = vim.api.nvim_set_keymap

-- keymap("n", "co", "<Plug>(git-conflict-ours)", opts)
-- keymap("n", "ct", "<Plug>(git-conflict-theirs)", opts)
-- keymap("n", "cb", "<Plug>(git-conflict-both)", opts)
-- keymap("n", "c0", "<Plug>(git-conflict-none)", opts)
-- keymap("n", "]x", "<Plug>(git-conflict-prev-conflict)", opts)
-- keymap("n", "[x", "<Plug>(git-conflict-next-conflict)", opts)

-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'GitConflictDetected',
--   callback = function()
--     vim.notify('Conflict detected in ' .. vim.fn.expand('<afile>'))
--     vim.keymap.set('n', 'cww', function()
--       engage.conflict_buster()
--       create_buffer_local_mappings()
--     end)
--   end,
-- })
--
local configs = {
  {
    default_mappings = false, -- disable buffer local mapping created by this plugin
    disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
    highlights = { -- They must have background color, otherwise the default color will be used
      incoming = 'DiffText',
      current = 'DiffAdd',
    },
  },
}

gitConflict.setup(configs)

----------------------------------------------------------------------

local status_ok, pqf = pcall(require, 'pqf')
if not status_ok then
  vim.notify('pqf' .. ' not found!')
  return
end

pqf.setup({
  signs = {
    error = 'E',
    warning = 'W',
    info = 'I',
    hint = 'H',
  },
})
