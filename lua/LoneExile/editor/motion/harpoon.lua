local M = {}

-- harpoon2 migration (2026-05-02):
--   * `branch = 'harpoon2'` is required — the master branch is harpoon v1
--     and ships a different, incompatible API.
--   * v1's `harpoon.mark.add_file()`, `harpoon.ui.nav_file(n)`, and
--     `harpoon.ui.toggle_quick_menu()` are all gone. v2 uses an OO API:
--       harpoon:list():add()
--       harpoon:list():select(n)
--       harpoon:list():prev()  / harpoon:list():next()
--       harpoon.ui:toggle_quick_menu(harpoon:list())
--   * v2 has no built-in Telescope picker; we implement the wrapper from
--     the upstream README inline (toggle_telescope) so the existing `ms`
--     muscle memory keeps working.

local function get_harpoon()
  local ok, harpoon = pcall(require, 'harpoon')
  if not ok then return nil end
  return harpoon
end

local function toggle_telescope()
  local harpoon = get_harpoon()
  if not harpoon then return end
  local ok_pickers, pickers = pcall(require, 'telescope.pickers')
  local ok_finders, finders = pcall(require, 'telescope.finders')
  local ok_conf, conf = pcall(require, 'telescope.config')
  if not (ok_pickers and ok_finders and ok_conf) then return end

  local list = harpoon:list()
  local file_paths = {}
  for _, item in ipairs(list.items or {}) do
    table.insert(file_paths, item.value)
  end

  pickers.new({}, {
    prompt_title = 'Harpoon',
    finder = finders.new_table({ results = file_paths }),
    previewer = conf.values.file_previewer({}),
    sorter = conf.values.generic_sorter({}),
  }):find()
end

M.keys = {
  {
    'm',
    desc = 'Harpoon',
  },
  {
    'ma',
    function()
      local h = get_harpoon(); if h then h:list():add() end
    end,
    desc = 'Harpoon',
    mode = 'n',
  },
  {
    'm.',
    function()
      local h = get_harpoon(); if h then h:list():next() end
    end,
    desc = 'Harpoon Next',
    mode = 'n',
  },
  {
    'm,',
    function()
      local h = get_harpoon(); if h then h:list():prev() end
    end,
    desc = 'Harpoon Prev',
    mode = 'n',
  },
  {
    'ms',
    toggle_telescope,
    desc = 'Search Files',
    mode = 'n',
  },
  {
    'mm',
    function()
      local h = get_harpoon(); if h then h.ui:toggle_quick_menu(h:list()) end
    end,
    desc = 'Harpoon UI',
    mode = 'n',
  },
}

M.setup = function()
  return {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'BufRead',
    keys = M.keys,
    config = function()
      local harpoon = get_harpoon()
      if not harpoon then return end

      -- harpoon2 setup is REQUIRED (it wires up autocmds for cwd/save/etc).
      harpoon:setup({
        settings = {
          save_on_toggle = false,
          sync_on_ui_close = true,
          mark_branch = false,
        },
      })

      local opts = { noremap = true, silent = true }

      vim.keymap.set('n', '<C-1>', '<cmd>OpenHarpoonNav<CR>', opts)
      vim.keymap.set('n', '<C-2>', function() harpoon:list():select(2) end, opts)
      vim.keymap.set('n', '<C-3>', function() harpoon:list():select(3) end, opts)
      vim.keymap.set('n', '<C-4>', function() harpoon:list():select(4) end, opts)
      vim.keymap.set('n', '<C-5>', function() harpoon:list():select(5) end, opts)

      vim.api.nvim_create_user_command('OpenHarpoonNav', function()
        harpoon:list():select(1)
      end, {})

      vim.api.nvim_create_user_command('OpenHarpoonAll', function()
        for i = 1, 9 do
          harpoon:list():select(i)
        end
      end, {})
    end,
  }
end

return M
