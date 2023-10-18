-- stylua: ignore

return {
  -- CMP
  { 'hrsh7th/nvim-cmp',                          true },

  -- LSP
  { 'neovim/nvim-lspconfig',                     true },
  -- { 'j-hui/fidget.nvim',                         false },
  -- { 'glepnir/lspsaga.nvim',                      true },
  { 'williamboman/mason.nvim',                   true },
  { 'williamboman/mason-lspconfig.nvim',         true },
  -- { 'WhoIsSethDaniel/mason-tool-installer.nvim', true },
  { 'folke/lua-dev.nvim',                        true },

  -- Editor
  { 'akinsho/toggleterm.nvim',                   true },

  -- Tool
  { 'nvim-telescope/telescope.nvim',             true },

  -- Treesitter
  { 'numToStr/Comment.nvim',                     true },
  { 'nvim-treesitter/nvim-treesitter',           true },
  { 'nvim-treesitter/nvim-treesitter-context',   true },
  { 'lukas-reineke/indent-blankline.nvim',       true },

  -- UI
  { 'goolord/alpha-nvim',                        true },
  { 'folke/tokyonight.nvim',                     true },
  { 'nvim-lualine/lualine.nvim',                 true },
  { 'nvim-neo-tree/neo-tree.nvim',               true },
  { 'rcarriga/nvim-notify',                      true },
  { 'folke/which-key.nvim',                      true },
}
