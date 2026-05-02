-- stylua: ignore

return {
  -- CMP
  { 'Saghen/blink.cmp',                          true }, -- replaced hrsh7th/nvim-cmp (Rust-backed engine)

  -- Dap
  { 'leoluz/nvim-dap-go',                        true },
  { 'mfussenegger/nvim-dap-python',              false },
  { 'mfussenegger/nvim-dap',                     true },
  { 'rcarriga/nvim-dap-ui',                      true },
  { 'theHamsta/nvim-dap-virtual-text',           true },
  { 'nvim-telescope/telescope-dap.nvim',         false },

  -- Editor
  { 'theprimeagen/refactoring.nvim',             true },
  { 'akinsho/toggleterm.nvim',                   true },
  { 'HakonHarnes/img-clip.nvim',                 false },
  { 'nvim-mini/mini.diff',                      false },

  { 'nvim-neotest/neotest',                      true },
  { 'andythigpen/nvim-coverage',                 true },
  { 'danymat/neogen',                            true },

  { 'olexsmir/gopher.nvim',                      true },

  -- Git
  { 'dlyongemallo/diffview.nvim',                true }, -- replaced sindrets fork (silent since June 2024)
  { 'lewis6991/gitsigns.nvim',                   true },
  { 'tpope/vim-fugitive',                        true },

  -- Motion
  { 'theprimeagen/harpoon',                      true },
  { 'folke/flash.nvim',                          true }, -- replaced phaazon/hop.nvim (abandoned)
  { 'nacro90/numb.nvim',                         true },
  { 'nvim-mini/mini.surround',                   true },
  { 'declancm/cinnamon.nvim',                    false },
  { 'chentoast/marks.nvim',                      true },

  -- Tool
  { 'ibhagwan/fzf-lua',                          true },

  { 'windwp/nvim-spectre',                       true },


  { 'nvim-mini/mini.ai',                       true },
  { 'tpope/vim-repeat',                          true },

  { 'nmac427/guess-indent.nvim',                 true },

  -- Other
  { 'glacambre/firenvim',                        true },
  -- { 'iamcco/markdown-preview.nvim',              false },
  -- { 'toppair/peek.nvim',                         true },
  { 'brianhuster/live-preview.nvim',             true },

  -- Treesitter
  { 'windwp/nvim-autopairs',                     true },
  { 'windwp/nvim-ts-autotag',                    true },
  { 'numToStr/Comment.nvim',                     true },
  -- { 'm-demare/hlargs.nvim',                      true },
  { 'nvim-treesitter/nvim-treesitter',           true },
  { 'nvim-treesitter/nvim-treesitter-context',   false },
  { 'folke/ts-comments.nvim',                    true },
  { 'lukas-reineke/indent-blankline.nvim',       true },
  { 'Wansmer/treesj',                            true },

  -- AI
  { 'zbirenbaum/copilot.lua',                    true },
  { 'CopilotC-Nvim/CopilotChat.nvim',            true },
  { 'olimorris/codecompanion.nvim',              false },
  { 'jackMort/ChatGPT.nvim',                     false },
  { 'yetone/avante.nvim',                        false },
  { 'ravitemer/mcphub.nvim',                     false },
  { 'folke/sidekick.nvim',                       true },

  -- DB
  { 'tpope/vim-dadbod',                          true },
  { 'kristijanhusak/vim-dadbod-completion',      true },
  { 'kristijanhusak/vim-dadbod-ui',              true },

  -- LSP
  { 'neovim/nvim-lspconfig',                     true },
  { 'williamboman/mason.nvim',                   true },
  { 'williamboman/mason-lspconfig.nvim',         true },
  { 'WhoIsSethDaniel/mason-tool-installer.nvim', true },

  { 'j-hui/fidget.nvim',                         true },
  { 'nvimdev/lspsaga.nvim',                      true }, -- org rename (was glepnir/)
  { 'stevearc/aerial.nvim',                      true },
  { 'stevearc/conform.nvim',                     true },
  { 'mfussenegger/nvim-lint',                    true },

  { 'folke/lazydev.nvim',                        true },
  { 'mrcjkb/rustaceanvim',                       true }, -- replaced rust-tools.nvim (archived Jan 2024)
  { 'b0o/schemastore.nvim',                      true },
  { 'pmizio/typescript-tools.nvim',              false }, -- replaced by vtsls (lsp/vtsls.lua)
  { 'ray-x/go.nvim',                             false },
  -- { 'laytan/tailwind-sorter.nvim',               true },
  
  { 'MaximilianLloyd/tw-values.nvim',            false },
  { 'Hoffs/omnisharp-extended-lsp.nvim',         true },
  { 'towolf/vim-helm',                           true },
  { 'hat0uma/csvview.nvim',                      true },

  -- UI
  { 'folke/tokyonight.nvim',                     true },
  { 'goolord/alpha-nvim',                        true },
  { 'nvim-lualine/lualine.nvim',                 true },
  { 'stevearc/dressing.nvim',                    true },
  { 'rcarriga/nvim-notify',                      true },

  { 'stevearc/oil.nvim',                         true },
  { 'nvim-neo-tree/neo-tree.nvim',               true },
  { 'folke/which-key.nvim',                      true },
  { 'kevinhwang91/nvim-ufo',                     true },

  { 'folke/todo-comments.nvim',                  true },
  { 'folke/snacks.nvim',                         true },
  { 'nvim-mini/mini.icons',                      true },
  { 'wakatime/vim-wakatime',                     false }
}
