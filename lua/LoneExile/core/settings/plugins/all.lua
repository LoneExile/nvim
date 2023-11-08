-- stylua: ignore

return {
  -- CMP
  { 'hrsh7th/nvim-cmp',                          true },

  -- Dap
  { 'leoluz/nvim-dap-go',                        true },
  { 'mfussenegger/nvim-dap-python',              true },
  { 'mfussenegger/nvim-dap',                     true },
  { 'rcarriga/nvim-dap-ui',                      true },
  { 'theHamsta/nvim-dap-virtual-text',           true },
  { 'nvim-telescope/telescope-dap.nvim',         false },

  -- Editor
  { 'theprimeagen/refactoring.nvim',             true },
  { 'akinsho/toggleterm.nvim',                   true },
  { 'nvchad/nvim-colorizer.lua',                 true },

  { 'nvim-neotest/neotest',                      true },
  { 'andythigpen/nvim-coverage',                 true },

  { 'olexsmir/gopher.nvim',                      true },

  -- Git
  { 'sindrets/diffview.nvim',                    true },
  { 'lewis6991/gitsigns.nvim',                   true },

  -- Motion
  { 'theprimeagen/harpoon',                      true },
  { 'phaazon/hop.nvim',                          true },
  { 'nacro90/numb.nvim',                         true },
  { 'echasnovski/mini.surround',                 true },

  -- Tool
  { 'ibhagwan/fzf-lua',                          true },

  { 'windwp/nvim-spectre',                       true },


  { 'wellle/targets.vim',                        true },
  { 'tpope/vim-repeat',                          true },

  { 'nmac427/guess-indent.nvim',                 true },
  { 'tomiis4/Hypersonic.nvim',                   false }, -- regex

  -- Other
  { 'glacambre/firenvim',                        true },
  { 'iamcco/markdown-preview.nvim',              true },

  -- Treesitter
  { 'windwp/nvim-autopairs',                     true },
  { 'windwp/nvim-ts-autotag',                    true },
  { 'numToStr/Comment.nvim',                     true },
  -- { 'm-demare/hlargs.nvim',                      true },
  { 'nvim-treesitter/nvim-treesitter',           true },
  { 'nvim-treesitter/nvim-treesitter-context',   true },
  { 'lukas-reineke/indent-blankline.nvim',       true },
  -- { 'Wansmer/treesj',                            true },

  -- AI
  { 'zbirenbaum/copilot.lua',                    true },

  -- LSP
  { 'neovim/nvim-lspconfig',                     true },
  { 'williamboman/mason.nvim',                   true },
  { 'williamboman/mason-lspconfig.nvim',         true },
  { 'WhoIsSethDaniel/mason-tool-installer.nvim', true },

  { 'j-hui/fidget.nvim',                         true },
  -- { 'glepnir/lspsaga.nvim',                      false },
  { 'stevearc/conform.nvim',                     true },
  { 'mfussenegger/nvim-lint',                    true },

  { 'folke/lua-dev.nvim',                        true },
  { 'simrat39/rust-tools.nvim',                  true },
  { 'b0o/schemastore.nvim',                      true },
  { 'jose-elias-alvarez/typescript.nvim',        true },
  { 'ray-x/go.nvim',                             false },
  { 'laytan/tailwind-sorter.nvim',               false },
  { 'MaximilianLloyd/tw-values.nvim',            true },
  { 'Hoffs/omnisharp-extended-lsp.nvim',         true },

  -- UI
  { 'folke/tokyonight.nvim',                     true },
  { 'goolord/alpha-nvim',                        true },
  { 'nvim-lualine/lualine.nvim',                 true },
  { 'stevearc/dressing.nvim',                    true },
  { 'rcarriga/nvim-notify',                      true },

  { 'stevearc/oil.nvim',                         true },
  { 'folke/which-key.nvim',                      true },

  -- { 'folke/todo-comments.nvim',                  true },
}
