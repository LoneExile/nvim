local M = {}

-- M.wh_key = {
--   wh_mappings = {
--     g = {
--       g = {
--         "<cmd>lua require('toggleterm.terminal').Terminal:new({ cmd = 'lazygit', hidden = true }):toggle()<CR>",
--         'LazyGit',
--         mode = { 'n' },
--       },
--     },
--   },
-- }

local lazygit = {
  cmd = 'lazygit',
  keymap = '<leader>gg',
  label = 'LazyGit',
  count = 1 + 100,
  direction = 'float' or M.terminal.direction,
  size = M.terminal.size,
}

M.setup = function(_, _) -- settings
  return {
    'akinsho/toggleterm.nvim',
    cmd = 'ToggleTerm',
    keys = { '<leader>', '<c-t>' },
    event = 'BufRead',
    config = function()
      local status_ok_ui, terminal = pcall(require, 'toggleterm')
      if not status_ok_ui then
        return
      end
      terminal.setup(M.terminal)
      M.add_exec(lazygit)
    end,
  }
end

M.add_exec = function(opts)
  local binary = opts.cmd:match('(%S+)')
  if vim.fn.executable(binary) ~= 1 then
    print('Executable not found: ' .. binary)
    return
  end

  vim.keymap.set({ 'n', 't' }, opts.keymap, function()
    M._exec_toggle({ cmd = opts.cmd, count = opts.count, direction = opts.direction })
  end, { desc = opts.label, noremap = true, silent = true })
end

M._exec_toggle = function(opts)
  local Terminal = require('toggleterm.terminal').Terminal
  local term = Terminal:new({ cmd = opts.cmd, count = opts.count, direction = opts.direction })
  term:toggle(M.terminal.size, opts.direction)
end

M.terminal = {
  on_config_done = nil,
  -- size can be a number or function which is passed the current terminal
  size = 20,
  open_mapping = [[<c-t>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = false,
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    border = 'curved',
    -- width = <value>,
    -- height = <value>,
    winblend = 0,
    highlights = {
      border = 'Normal',
      background = 'Normal',
    },
  },
  winbar = {
    enabled = true,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end,
  },
  execs = {},
}

return M
