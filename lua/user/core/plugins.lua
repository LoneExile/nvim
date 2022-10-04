local pluginTable = {
  -- base
  { 'wbthomason/packer.nvim' },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-lua/popup.nvim' },
  { 'kyazdani42/nvim-web-devicons' },
  -- { 'folke/which-key.nvim' },
  { 'LoneExile/which-key.nvim' }, -- NOTE: use hydra and my brain instead

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(vim.cmd, 'TSUpdate')
    end,
  },
  { 'p00f/nvim-ts-rainbow', event = 'VimEnter' },
  { 'nvim-treesitter/nvim-treesitter-context', event = 'VimEnter' },
  { 'windwp/nvim-ts-autotag', event = 'VimEnter' },
  { 'RRethy/nvim-treesitter-textsubjects', event = 'VimEnter' },
  { 'JoosepAlviste/nvim-ts-context-commentstring', event = 'VimEnter' },
  { 'nvim-treesitter/nvim-treesitter-textobjects', event = 'VimEnter' }, -- movement around text objects
  { 'numToStr/Comment.nvim', event = 'VimEnter' },
  { 'lukas-reineke/indent-blankline.nvim', event = 'VimEnter' },
  { 'andymass/vim-matchup' },
  { 'm-demare/hlargs.nvim', requires = { 'nvim-treesitter/nvim-treesitter' } },
  { 'windwp/nvim-autopairs', requires = { 'nvim-treesitter/nvim-treesitter' } },
  { 'RRethy/vim-illuminate', requires = { 'nvim-treesitter/nvim-treesitter' } }, -- NOTE: no need to HL word?
  -- { 'David-Kunz/markid' }, -- highlight variable to use same color

  -- optimization
  { 'lewis6991/impatient.nvim' },
  { 'antoinemadec/FixCursorHold.nvim' },
  { 'dstein64/vim-startuptime', opt = true, cmd = 'StartupTime' },
  -- { 'nathom/filetype.nvim' },

  ---- editor
  { 'tpope/vim-repeat' },
  { 'wellle/targets.vim' }, -- textobject
  { 'dhruvasagar/vim-open-url' },

  -- tool
  { 'windwp/nvim-spectre' },
  { 'akinsho/toggleterm.nvim' },
  { 'darazaki/indent-o-matic' }, -- NOTE: what is this can do honestly
  -- { "nmac427/guess-indent.nvim" },

  -- telescope
  { 'nvim-telescope/telescope.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  -- { "nvim-telescope/telescope-ui-select.nvim" },

  -- productivity
  {
    'folke/zen-mode.nvim',
    opt = true,
    cmd = 'ZenMode',
    config = function()
      require('user.ui.productivity.zen')
    end,
  },
  {
    'folke/twilight.nvim',
    opt = true,
    cmd = 'Twilight',
    config = function()
      require('user.ui.productivity.twilight')
    end,
  },
  { 'folke/todo-comments.nvim' },

  -- code
  {
    'AckslD/swenv.nvim',
    opt = true,
    ft = { 'python' },
    config = function()
      require('user.editor.coding.swenv')
    end,
  },
  { 'theprimeagen/refactoring.nvim' },
  {
    '0x100101/lab.nvim',
    run = 'cd js && npm ci',
    opt = true,
    ft = { 'javascript', 'typescript', 'lua', 'python' },
    config = function()
      require('user.editor.coding.lab')
    end,
  },
  { 'michaelb/sniprun', run = 'bash ./install.sh' },
  { 'metakirby5/codi.vim', opt = true, cmd = 'Codi' }, -- NOTE: buggy
  {
    'ray-x/web-tools.nvim',
    opt = true,
    cmd = { 'BrowserOpen', 'Browserstop', 'BrowserRestart' },
    filetypes = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
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

  --git
  { 'lewis6991/gitsigns.nvim' },
  {
    'sindrets/diffview.nvim',
    opt = true,
    cmd = 'DiffviewOpen',
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
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'jose-elias-alvarez/typescript.nvim' },
  { 'folke/lua-dev.nvim' },
  -- {
  --   'simrat39/rust-tools.nvim',
  --   ft = { 'rust' },
  --   config = function()
  --     require('user.lsp.settings.rust')
  --   end,
  --   requires = {
  --     {
  --       'saecki/crates.nvim',
  --       tag = 'v0.3.0',
  --       requires = { 'nvim-lua/plenary.nvim' },
  --       config = function()
  --         require('crates').setup()
  --       end,
  --     },
  --   },
  -- },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    -- event = 'InsertEnter',
    -- config = function()
    --   require('user.lsp.cmp')
    -- end,
    requires = {
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'LuaSnip' },
      { 'jcha0713/cmp-tw2css', after = 'nvim-cmp' },
    },
  },

  -- Snippets
  {
    'L3MON4D3/LuaSnip', -- event = 'InsertCharPre',
  },
  -- { "rafamadriz/friendly-snippets" },

  { 'glepnir/lspsaga.nvim', branch = 'main' },
  -- { 'SmiteshP/nvim-navic' },
  { 'j-hui/fidget.nvim' }, -- NOTE: Hmmmmm
  -- { 'lvimuser/lsp-inlayhints.nvim' }, -- TODO: not working

  { 'jose-elias-alvarez/null-ls.nvim' },
  {
    'zbirenbaum/copilot.lua',
    -- commit = '',
    event = { 'VimEnter' },
    config = function()
      vim.schedule(function()
        require('user.lsp.cmp.copilot').setup()
      end)
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    -- commit = '',
    after = { 'copilot.lua' },
    config = function()
      require('user.lsp.cmp.copilot').cmpSetup()
    end,
  },

  -- debugger
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } },
  { 'theHamsta/nvim-dap-virtual-text', requires = { 'mfussenegger/nvim-dap' } }, -- NOTE: use dap-ui hover instead?
  -- { "nvim-telescope/telescope-dap.nvim" },
  {
    'mfussenegger/nvim-dap-python',
    requires = { 'mfussenegger/nvim-dap' },
    ft = { 'python' },
    config = function()
      require('dap-python').setup('~/.pyenv/shims/python')
    end,
  },
  {
    -- https://medium.com/gulpjs/gulp-util-ca3b1f9f9ac5
    'mxsdev/nvim-dap-vscode-js',
    requires = {
      { 'mfussenegger/nvim-dap' },
      {
        'microsoft/vscode-js-debug',
        opt = true,
        run = 'npm install --legacy-peer-deps && npm run compile',
      },
    },
  },
  {
    'leoluz/nvim-dap-go',
    ft = { 'go' },
    run = 'go install github.com/go-delve/delve/cmd/dlv@latest',
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
    branch = 'v2.x',
    requires = { { 'MunifTanjim/nui.nvim' }, { 's1n7ax/nvim-window-picker' } },
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
    requires = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    config = function()
      require('user.ui.windows')
    end,
  },

  -- Colorschemes
  { 'folke/tokyonight.nvim' },
  -- { "LunarVim/onedarker.nvim" },
  -- { "EdenEast/nightfox.nvim" },
  -- { "glepnir/zephyr-nvim" },
  -- { 'catppuccin/nvim' },
  -- { 'lunarvim/darkplus.nvim' },

  -- experimental
  -- {
  --   'Dax89/ide.nvim',
  --   config = function()
  --     require('ide').setup({
  --       ignore_filetypes = {},
  --       root_patterns = { '.git/' },
  --       shadow_build = false,
  --       auto_create = true,
  --       debug = false,
  --       build_dir = 'build',
  --       project_file = 'project.nvide',
  --       mappings = {},
  --       quickfix = {
  --         pos = 'bel',
  --       },
  --       integrations = {
  --         dap = {
  --           enable = false,
  --         },
  --         dapui = {
  --           enable = false,
  --         },
  --       },
  --     })
  --   end,
  --   requires = {
  --     { 'nvim-lua/plenary.nvim' },
  --     { 'rcarriga/nvim-notify' }, -- Notifications Popup (Optional)
  --     { 'stevearc/dressing.nvim' }, -- Improved UI (Optional)
  --     { 'mfussenegger/nvim-dap' }, -- DAP Support (Optional)
  --     { 'rcarriga/nvim-dap-ui' }, -- DAP-UI Support (Optional)
  --   },
  -- },

  -- {
  --   'folke/noice.nvim',
  --   event = 'VimEnter',
  --   config = function()
  --     require('noice').setup()
  --   end,
  --   requires = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     'MunifTanjim/nui.nvim',
  --     'rcarriga/nvim-notify',
  --     'hrsh7th/nvim-cmp',
  --   },
  -- },
}

return pluginTable

-----------------------------------------------------------------------------------------------

-- check it out later
-- anuvyklack/windows.nvim -- cool
-- edluffy/hologram.nvim
-- samodostal/image.nvim
-- jbyuki/instant.nvim
-- j-hui/fidget.nvim, -- show loading lsp
-- AckslD/nvim-neoclip.lua
-- mattn/emmet-vim
-- numToStr/FTerm.nvim
-- rmagatti/alternate-toggler
-- https://git.sr.ht/~whynothugo/lsp_lines.nvim
-- simrat39/symbols-outline.nvim
-- weilbith/nvim-code-action-menu
-- andythigpen/nvim-coverage

-----------------------------------------------------------------------------------------------

-- debugger
-- nvim-neotest/neotest
-----------------------------------------------------------------------------------------------

-- look cool but not for me
-- { "matbme/JABS.nvim" },

-----------------------------------------------------------------------------------------------
