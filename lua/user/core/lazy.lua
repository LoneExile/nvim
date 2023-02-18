local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-----------------------------------------------------
local root = 'user'
local settings = require(root .. '.core.settings')

local config_location = vim.fn.stdpath('config') .. '/lua/' .. root
local all_files = vim.fn.glob(config_location .. '/**/*.lua', true, true)
local files = vim.tbl_filter(function(file)
  return not vim.endswith(file, 'lazy.lua') and not vim.startswith(file, '_')
end, all_files)
-- print(vim.inspect(files))

files = vim.tbl_filter(function(file)
  local folder = vim.fn.fnamemodify(file, ':h')
  local init_file = folder .. '/init.lua'
  if vim.fn.filereadable(init_file) == 1 then
    return vim.endswith(file, 'init.lua')
  end
  return true
end, files)

files = vim.tbl_filter(function(file)
  local folder = vim.fn.fnamemodify(file, ':h')
  local folder_name = vim.fn.fnamemodify(folder, ':t')
  local list = {
    'utils',
    'autoCmd',
    'core',
    'keymaps',
    -- 'servers',
  }
  return not vim.tbl_contains(list, folder_name)
end, files)

-- print(vim.inspect(files))

local plugins = {}

for _, file in ipairs(files) do
  local file_name = vim.fn.fnamemodify(file, ':t:r')
  -- print('file_name: ', file_name)
  local folder = vim.fn.fnamemodify(file, ':h')
  -- print('folder: ', folder)
  local folder_name = vim.fn.fnamemodify(folder, ':t')
  -- print('folder_name: ', folder_name)

  if vim.fn.fnamemodify(folder, ':h') == config_location then
    local location = 'user.' .. folder_name .. '.' .. file_name
    location = vim.fn.substitute(location, '.init', '', 'g')
    -- print('1: ', location)
    table.insert(plugins, require(location).setup(settings, location))
  else
    local location = vim.fn.matchstr(file, [[user/.*.lua]])
    location = vim.fn.substitute(location, '/', '.', 'g')
    location = vim.fn.substitute(location, '.init', '', 'g')
    location = vim.fn.substitute(location, '.lua$', '', 'g')
    -- if vim.endswith(location, '.lua') then
    --   -- remove only the last occurence of .lua
    --   location = vim.fn.substitute(location, '.lua$', '', 'g')
    -- end
    -- print('2:', location)

    -----------------------------------------------------
    local plugin_config = require(location).setup(settings, location)
    -- print(vim.inspect(plugin_config))
    -- print(plugin_config.test)
    -----------------------------------------------------

    table.insert(plugins, plugin_config)
  end
  -- print('-----------------')
end

-- print(vim.inspect(files))
-- print(vim.inspect(plugins))

-----------------------------------------------------

-- local plugins = { -- base
--   { 'nvim-lua/plenary.nvim' },
--   { 'nvim-lua/popup.nvim' },
--   { 'nvim-tree/nvim-web-devicons' },

--   -- {
--   --   'glacambre/firenvim',
--   --   build = function()
--   --     vim.fn['firenvim#install'](0)
--   --   end,
--   -- },

--   -- Treesitter
--   {
--     'nvim-treesitter/nvim-treesitter',
--     event = 'BufRead',
--     build = function()
--       ---@diagnostic disable-next-line: param-type-mismatch
--       pcall(vim.cmd, 'TSUpdate')
--     end,
--   },
--   { 'mrjones2014/nvim-ts-rainbow', event = 'VimEnter' },
--   { 'nvim-treesitter/nvim-treesitter-context', event = 'VimEnter' },
--   { 'windwp/nvim-ts-autotag', event = 'VimEnter' },
--   { 'RRethy/nvim-treesitter-textsubjects', event = 'VimEnter' },
--   { 'JoosepAlviste/nvim-ts-context-commentstring', event = 'VimEnter' },
--   { 'nvim-treesitter/nvim-treesitter-textobjects', event = 'VimEnter' }, -- movement around text objects
--   { 'numToStr/Comment.nvim', event = 'VimEnter' },
--   { 'lukas-reineke/indent-blankline.nvim', event = 'VimEnter' },
--   { 'andymass/vim-matchup', event = 'VimEnter' },
--   { 'm-demare/hlargs.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter' }, event = 'VimEnter' },
--   { 'windwp/nvim-autopairs', dependencies = { 'nvim-treesitter/nvim-treesitter' }, event = 'InsertEnter' },
--   { 'RRethy/vim-illuminate', dependencies = { 'nvim-treesitter/nvim-treesitter' }, event = 'VimEnter' }, -- NOTE: no need to HL word?
--   { 'axelvc/template-string.nvim', event = 'InsertEnter' },
--   -- { 'David-Kunz/markid' }, -- highlight variable to use same color

--   -- lazyimization
--   { 'lewis6991/impatient.nvim' },
--   { 'antoinemadec/FixCursorHold.nvim' },
--   { 'dstein64/vim-startuptime', lazy = true, cmd = 'StartupTime' },
--   -- { 'nathom/filetype.nvim' },

--   ---- editor
--   { 'tpope/vim-repeat', event = 'VimEnter' },
--   { 'wellle/targets.vim', event = 'VimEnter' }, -- textobject
--   { 'dhruvasagar/vim-open-url', event = 'VimEnter' },
--   {
--     'iamcco/markdown-preview.nvim',
--     ft = { 'markdown' },
--     build = function()
--       vim.fn['mkdp#util#install']()
--     end,
--   },

--   -- tool
--   { 'windwp/nvim-spectre', lazy = true },
--   { 'akinsho/toggleterm.nvim' },
--   { 'darazaki/indent-o-matic' }, -- NOTE: what is this can do honestly

--   -- telescope
--   { 'nvim-telescope/telescope.nvim' },
--   { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
--   -- { "nvim-telescope/telescope-ui-select.nvim" },

--   -- productivity
--   {
--     'folke/zen-mode.nvim',
--     lazy = true,
--     cmd = 'ZenMode',
--     config = function()
--       require('user.ui.productivity.zen')
--     end,
--   },
--   {
--     'folke/twilight.nvim',
--     lazy = true,
--     cmd = 'Twilight',
--     config = function()
--       require('user.ui.productivity.twilight')
--     end,
--   },
--   { 'folke/todo-comments.nvim' },
--   {
--     'LoneExile/autolist.nvim',
--     ft = { 'markdown', 'text', 'tex', 'plaintex' },
--     config = function()
--       require('user.editor.motion.autolist')
--     end,
--   },

--   -- code
--   {
--     'AckslD/swenv.nvim',
--     lazy = true,
--     ft = { 'python' },
--     config = function()
--       require('user.editor.coding.swenv')
--     end,
--   },
--   { 'theprimeagen/refactoring.nvim' },
--   {
--     '0x100101/lab.nvim',
--     build = 'cd js && npm ci',
--     ft = { 'javascript', 'typescript', 'lua', 'python' },
--     config = function()
--       require('user.editor.coding.lab')
--     end,
--   },
--   { 'michaelb/sniprun', build = 'bash ./install.sh' },
--   { 'metakirby5/codi.vim', lazy = true, cmd = 'Codi' }, -- NOTE: buggy
--   {
--     'ray-x/web-tools.nvim',
--     lazy = true,
--     cmd = { 'BrowserOpen', 'Browserstop', 'BrowserRestart' },
--     ft = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
--     config = function()
--       require('web-tools').setup()
--     end,
--   },

--   --motion
--   { 'echasnovski/mini.nvim', event = 'BufRead' },
--   { 'phaazon/hop.nvim', event = 'BufRead' },
--   { 'nacro90/numb.nvim', event = 'BufRead' },
--   { 'declancm/cinnamon.nvim', event = 'BufRead' },
--   { 'chentoast/marks.nvim', event = 'BufRead' }, -- NOTE: am i really use mark?
--   -- {
--   --   'cbochs/portal.nvim',
--   --   config = function()
--   --     require('portal').setup({})
--   --   end,
--   -- },

--   --git
--   { 'lewis6991/gitsigns.nvim', event = { 'BufRead', 'BufNewFile' } },
--   {
--     'sindrets/diffview.nvim',
--     lazy = true,
--     cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
--     config = function()
--       require('user.editor.git.diffView')
--     end,
--   },
--   { 'ThePrimeagen/git-worktree.nvim' }, -- NOTE: just use it on cmdline?

--   -- color
--   { 'nvchad/nvim-colorizer.lua' },
--   { 'max397574/colortils.nvim' },

--   -- debugger
--   { 'mfussenegger/nvim-jap' },
--   { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap' } },
--   {
--     'theHamsta/nvim-dap-virtual-text',
--     dependencies = { 'mfussenegger/nvim-dap' },
--     config = function()
--       require('nvim-dap-virtual-text').setup({})
--     end,
--   },
--   -- { "nvim-telescope/telescope-dap.nvim" },

--   -- UI
--   { 'ahmedkhalf/project.nvim' },
--   { 'stevearc/dressing.nvim' },
--   {
--     'anuvyklack/windows.nvim',
--     event = 'WinEnter',
--     dependencies = {
--       'anuvyklack/middleclass',
--       'anuvyklack/animation.nvim',
--     },
--     config = function()
--       require('user.ui.windows')
--     end,
--   },

local status, lazy = pcall(require, 'lazy')
if not status then
  return
end

local opts = {
  lockfile = vim.fn.stdpath('config') .. '/resources/lazy-lock.json',
}

lazy.setup(plugins, opts)
