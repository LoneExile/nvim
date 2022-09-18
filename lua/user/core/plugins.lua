local pluginTable = {
	-- base
	{ "wbthomason/packer.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/popup.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	{ "folke/which-key.nvim" },

	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter" },
	{ "p00f/nvim-ts-rainbow" },
	{ "numToStr/Comment.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "windwp/nvim-autopairs" },
	{ "windwp/nvim-ts-autotag" },

	-- optimization
	{ "lewis6991/impatient.nvim" },
	{ "antoinemadec/FixCursorHold.nvim" },

	-- editor
	{ "windwp/nvim-spectre" },
	{ "nacro90/numb.nvim" },
	{ "michaelb/sniprun", run = "bash ./install.sh" },
	{ "metakirby5/codi.vim", cmd = "codi" },
	{ "tpope/vim-repeat" },
	{ "folke/zen-mode.nvim" },
	{ "theprimeagen/harpoon" },
	{ "dhruvasagar/vim-open-url" },
	{ "darazaki/indent-o-matic" },
	{ "nmac427/guess-indent.nvim" },
	{ "declancm/cinnamon.nvim" },
	{ "shatur/neovim-session-manager" },
	{ "max397574/better-escape.nvim" },
	{ "theprimeagen/refactoring.nvim" },
	{ "echasnovski/mini.nvim" },
	{ "nvchad/nvim-colorizer.lua" },
	{ "max397574/colortils.nvim" },
	{ "nvim-telescope/telescope.nvim" },
	{ "nvim-telescope/telescope-fzf-native.nvim" },
	{ "lewis6991/gitsigns.nvim" },
	{ "akinsho/git-conflict.nvim", tag = "*" },
	{ "https://gitlab.com/yorickpeterse/nvim-pqf", as = "nvim-pqf" },
	{ "sindrets/diffview.nvim" },

	-- lsp
	{
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	},
	{ "folke/lua-dev.nvim" },
	{ "glepnir/lspsaga.nvim", branch = "main" },
	{ "SmiteshP/nvim-navic" },
	{ "github/copilot.vim" },
	{ "jose-elias-alvarez/null-ls.nvim" },
	{
		"zbirenbaum/copilot.lua",
		commit = "ede741d935cf5d962c9a9e44db2400ed1a4aaf13",
		event = { "VimEnter" },
		config = function()
			vim.defer_fn(function()
				require("copilot").setup()
			end, 100)
		end,
	},
	{ "zbirenbaum/copilot-cmp", commit = "67825246fa2aa6226ec3320d554640aa4697e1b1", module = "copilot_cmp" },

	-- debugger
	{ "mfussenegger/nvim-dap" },
	{ "Pocco81/dap-buddy.nvim" },
	{ "rcarriga/nvim-dap-ui" },
	{ "theHamsta/nvim-dap-virtual-text" },
	{ "nvim-telescope/telescope-dap.nvim" },
	{ "mfussenegger/nvim-dap-python" },
	{ "leoluz/nvim-dap-go" },

	-- UI
	{ "goolord/alpha-nvim" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = { "MunifTanjim/nui.nvim", "s1n7ax/nvim-window-picker" },
	},
	{ "akinsho/bufferline.nvim" },
	{ "nvim-lualine/lualine.nvim" },
	{ "akinsho/toggleterm.nvim" },
	{ "rcarriga/nvim-notify" },
	{ "ahmedkhalf/project.nvim" },
	{ "b0o/schemastore.nvim" },

	-- Colorschemes
	{ "LunarVim/onedarker.nvim" },
	{ "EdenEast/nightfox.nvim" },
	{ "glepnir/zephyr-nvim" },
	{ "folke/tokyonight.nvim" },
}

return pluginTable

-- edluffy/hologram.nvim
-- samodostal/image.nvim
-- kyazdani42/nvim-tree.lua