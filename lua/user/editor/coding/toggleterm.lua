local M = {}

M.terminal = {
  on_config_done = nil,
  -- size can be a number or function which is passed the current terminal
  size = 20,
  -- open_mapping = [[<c-\>]],
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

M.tool = function()
  -- https://github.com/akinsho/toggleterm.nvim#custom-terminal-usage

  -- TODO: check is command is available before mapping
  M.terminal.execs = {
    { 'lazygit', '<leader>gg', 'LazyGit', 'float' },
    { 'lazygit', '<leader>tg', 'LazyGit', 'float' },
  }

  local linux = {
    {
      'nnn -er',
      '<leader>tn',
      'nnn',
      'float',
    },
    {
      'btop',
      '<leader>tt',
      'btop',
      'float',
    },
    {
      'bash ' .. vim.fn.stdpath('config') .. '/resources/scripts/cht/cht.sh',
      '<leader>tc',
      'cheet sheet',
      'float',
    },
  }

  local CURRENTOS = require('user.utils.requirements').CURRENTOS
  if CURRENTOS == 'Linux' or CURRENTOS == 'Darwin' then
    for _, v in ipairs(linux) do
      table.insert(M.terminal.execs, v)
    end
  end
end

M.setup = function()
  return {
    'akinsho/toggleterm.nvim',
    config = function()
      local status_ok_ui, terminal = pcall(require, 'toggleterm')
      if not status_ok_ui then
        return
      end
      M.tool()
      terminal.setup(M.terminal)

      for i, exec in pairs(M.terminal.execs) do
        local opts = {
          cmd = exec[1],
          keymap = exec[2],
          label = exec[3],
          count = i + 100,
          direction = exec[4] or M.terminal.direction,
          size = M.terminal.size,
        }

        M.add_exec(opts)
      end
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

return M
