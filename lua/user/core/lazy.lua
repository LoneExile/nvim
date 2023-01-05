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

local plugins = {
  -- base
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-lua/popup.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'folke/which-key.nvim' },
  -- { 'LoneExile/which-key.nvim' }, -- NOTE: use hydra and my brain instead
  -- {
  --   'glacambre/firenvim',
  --   build = function()
  --     vim.fn['firenvim#install'](0)
  --   end,
  -- },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(vim.cmd, 'TSUpdate')
    end,
  },
  { 'mrjones2014/nvim-ts-rainbow', event = 'VimEnter' },
  { 'nvim-treesitter/nvim-treesitter-context', event = 'VimEnter' },
  { 'windwp/nvim-ts-autotag', event = 'VimEnter' },
  { 'RRethy/nvim-treesitter-textsubjects', event = 'VimEnter' },
  { 'JoosepAlviste/nvim-ts-context-commentstring', event = 'VimEnter' },
  { 'nvim-treesitter/nvim-treesitter-textobjects', event = 'VimEnter' }, -- movement around text objects
  { 'numToStr/Comment.nvim', event = 'VimEnter' },
  { 'lukas-reineke/indent-blankline.nvim', event = 'VimEnter' },
  { 'andymass/vim-matchup' },
  { 'm-demare/hlargs.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
  { 'windwp/nvim-autopairs', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
  { 'RRethy/vim-illuminate', dependencies = { 'nvim-treesitter/nvim-treesitter' } }, -- NOTE: no need to HL word?
  -- { 'David-Kunz/markid' }, -- highlight variable to use same color
  { 'axelvc/template-string.nvim' },

  -- lazyimization
  { 'lewis6991/impatient.nvim' },
  { 'antoinemadec/FixCursorHold.nvim' },
  { 'dstein64/vim-startuptime', lazy = true, cmd = 'StartupTime' },
  -- { 'nathom/filetype.nvim' },

  ---- editor
  { 'tpope/vim-repeat' },
  { 'wellle/targets.vim' }, -- textobject
  { 'dhruvasagar/vim-open-url' },

  -- tool
  { 'windwp/nvim-spectre' },
  { 'akinsho/toggleterm.nvim' },
  { 'darazaki/indent-o-matic' }, -- NOTE: what is this can do honestly

  -- telescope
  { 'nvim-telescope/telescope.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  -- { "nvim-telescope/telescope-ui-select.nvim" },

  -- productivity
  {
    'folke/zen-mode.nvim',
    lazy = true,
    cmd = 'ZenMode',
    config = function()
      require('user.ui.productivity.zen')
    end,
  },
  {
    'folke/twilight.nvim',
    lazy = true,
    cmd = 'Twilight',
    config = function()
      require('user.ui.productivity.twilight')
    end,
  },
  { 'folke/todo-comments.nvim' },
  { 'gaoDean/autolist.nvim' },

  -- code
  {
    'AckslD/swenv.nvim',
    lazy = true,
    ft = { 'python' },
    config = function()
      require('user.editor.coding.swenv')
    end,
  },
  { 'theprimeagen/refactoring.nvim' },
  {
    '0x100101/lab.nvim',
    build = 'cd js && npm ci',
    ft = { 'javascript', 'typescript', 'lua', 'python' },
    config = function()
      require('user.editor.coding.lab')
    end,
  },
  { 'michaelb/sniprun', build = 'bash ./install.sh' },
  { 'metakirby5/codi.vim', lazy = true, cmd = 'Codi' }, -- NOTE: buggy
  {
    'ray-x/web-tools.nvim',
    lazy = true,
    cmd = { 'BrowserOpen', 'Browserstop', 'BrowserRestart' },
    ft = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    config = function()
      require('web-tools').setup()
    end,
  },

  --motion
  { 'echasnovski/mini.nvim' },
  { 'phaazon/hop.nvim' },
  { 'nacro90/numb.nvim' },
  { 'declancm/cinnamon.nvim' },
  { 'theprimeagen/harpoon' },
  { 'chentoast/marks.nvim' }, -- NOTE: am i really use mark?
  -- {
  --   'cbochs/portal.nvim',
  --   config = function()
  --     require('portal').setup({})
  --   end,
  -- },

  --git
  { 'lewis6991/gitsigns.nvim' },
  {
    'sindrets/diffview.nvim',
    lazy = true,
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    config = function()
      require('user.editor.git.diffView')
    end,
  },
  { 'ThePrimeagen/git-worktree.nvim' }, -- NOTE: just use it on cmdline?

  -- color
  { 'nvchad/nvim-colorizer.lua' },
  { 'max397574/colortils.nvim' },

  -- LSP Support
  { 'neovim/nvim-lspconfig' },
  { 'jose-elias-alvarez/null-ls.nvim' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  { 'jose-elias-alvarez/typescript.nvim' },
  { 'folke/lua-dev.nvim' },
  {
    'simrat39/rust-tools.nvim',
    ft = { 'rust' },
    config = function()
      require('user.lsp.settings.rust')
    end,
    dependencies = {
      {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        -- tag = 'v0.3.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
          require('crates').setup()
        end,
      },
    },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'jcha0713/cmp-tw2css' },
    },
  },

  -- Snippets
  {
    'L3MON4D3/LuaSnip', -- event = 'InsertCharPre',
  },
  -- { "rafamadriz/friendly-snippets" },

  { 'glepnir/lspsaga.nvim', branch = 'main' },
  { 'SmiteshP/nvim-navic' },
  { 'j-hui/fidget.nvim' }, -- NOTE: Hmmmmm
  -- { 'lvimuser/lsp-inlayhints.nvim' }, -- TODO: not working

  {
    'zbirenbaum/copilot.lua',
    event = { 'VimEnter' },
    config = function()
      vim.schedule(function()
        require('user.lsp.ai.copilot').setup()
      end)
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = { 'copilot.lua' },
    config = function()
      require('user.lsp.ai.copilot').cmpSetup()
    end,
  },

  {
    'jackMort/ChatGPT.nvim',
    config = function()
      require('user.lsp.ai.chatGPT').setupGPT()
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },

  {
    'dense-analysis/neural',
    config = function()
      require('user.lsp.ai.chatGPT').setupNeural()
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'ElPiloto/significant.nvim',
    },
  },

  -- debugger
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap' } },
  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('nvim-dap-virtual-text').setup({})
    end,
  },
  -- { "nvim-telescope/telescope-dap.nvim" },
  {
    'mfussenegger/nvim-dap-python',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = { 'python' },
    config = function()
      require('dap-python').setup('~/.pyenv/shims/python')
    end,
  },
  {
    'mxsdev/nvim-dap-vscode-js',
    -- ft = { 'typescript', 'javascript' },
    dependencies = {
      { 'mfussenegger/nvim-dap' },
    },
  },
  {
    'leoluz/nvim-dap-go',
    ft = { 'go' },
    build = 'go install github.com/go-delve/delve/cmd/dlv@latest',
    config = function()
      require('dap-go').setup()
    end,
  },

  -- UI
  {
    'goolord/alpha-nvim',
    config = function()
      require('user.ui.alpha')
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    event = 'BufWinEnter',
    config = function()
      vim.schedule(function()
        require('user.ui.neoTree')
      end)
    end,
    -- branch = 'v2.x',
    branch = 'main',
    dependencies = { { 'MunifTanjim/nui.nvim' }, { 's1n7ax/nvim-window-picker' } },
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      vim.schedule(function()
        -- vim.cmd([[lua vim.o.ls=1]]) -- enable statusline
        require('user.ui.lualine')
      end)
    end,
  },
  { 'rcarriga/nvim-notify' },
  { 'ahmedkhalf/project.nvim' },
  { 'b0o/schemastore.nvim' },
  { 'stevearc/dressing.nvim' },
  {
    'anuvyklack/windows.nvim',
    event = 'WinEnter',
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    config = function()
      require('user.ui.windows')
    end,
  },

  -- Colorschemes
  { 'folke/tokyonight.nvim' },
  -- { 'catppuccin/nvim', as = 'catppuccin' },
  -- { "EdenEast/nightfox.nvim" },
  -- { "glepnir/zephyr-nvim" },
  -- { 'lunarvim/darkplus.nvim' },
  -- { "LunarVim/onedarker.nvim" },
}

local status, lazy = pcall(require, 'lazy')
if not status then
  return
end

lazy.setup(plugins)
