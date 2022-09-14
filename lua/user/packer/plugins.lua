local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("packer" .. " not found!")
	return
end

-- Have packer use a popup window
packer.init({
	max_jobs = 20,
	snapshot_path = "./plugin/snapshot", -- Default save directory for snapshots
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- base
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "nvim-lua/popup.nvim" })
	use({ "kyazdani42/nvim-web-devicons" })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter" })
	use({ "p00f/nvim-ts-rainbow" })
	use({ "numToStr/Comment.nvim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({ "nvim-treesitter/nvim-treesitter-context" })
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "windwp/nvim-autopairs" })
	use({ "windwp/nvim-ts-autotag" })

	-- utility
	use({ "lewis6991/impatient.nvim" })
	use({ "antoinemadec/FixCursorHold.nvim" })

	use({ "windwp/nvim-spectre" })
	use({ "nacro90/numb.nvim" })
	use({ "michaelb/sniprun", run = "bash ./install.sh" })
	use({ "metakirby5/codi.vim", cmd = "Codi" })
	use({ "tpope/vim-repeat" })
	use({ "folke/zen-mode.nvim" })
	use({ "ThePrimeagen/harpoon" })
	use({ "dhruvasagar/vim-open-url" })
	use({ "Darazaki/indent-o-matic" })
	use({ "NMAC427/guess-indent.nvim" })
	use({ "declancm/cinnamon.nvim" })
	use({ "Shatur/neovim-session-manager" })
	use({ "max397574/better-escape.nvim" })

	-- color management
	use({ "norcalli/nvim-colorizer.lua" })
	use({ "max397574/colortils.nvim" })
	use({ "folke/tokyonight.nvim" })

	-- LSP
	vim.g.python3_host_prog = "$HOME/.pyenv/versions/nvim/bin/python"
	use({
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
	})
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "folke/lua-dev.nvim" })
	use({ "glepnir/lspsaga.nvim", branch = "main" })
	use({ "github/copilot.vim" })

	use({
		"zbirenbaum/copilot.lua",
		commit = "ede741d935cf5d962c9a9e44db2400ed1a4aaf13",
		event = { "VimEnter" },
		config = function()
			vim.defer_fn(function()
				require("copilot").setup()
			end, 100)
		end,
	})
	use({
		"zbirenbaum/copilot-cmp",
		commit = "67825246fa2aa6226ec3320d554640aa4697e1b1",
		module = "copilot_cmp",
	})

	-- use({
	-- 	"zbirenbaum/copilot.lua",
	-- 	event = { "VimEnter" },
	-- 	config = function()
	-- 		vim.defer_fn(function()
	-- 			require("copilot").setup()
	-- 		end, 100)
	-- 	end,
	-- })
	-- use({
	-- 	"zbirenbaum/copilot-cmp",
	-- 	after = { "copilot.lua" },
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end,
	-- })

	use({ "ThePrimeagen/refactoring.nvim" })
	use({ "echasnovski/mini.nvim" })

	-- debugger
	use({ "mfussenegger/nvim-dap" })
	use({ "Pocco81/dap-buddy.nvim" })
	use({ "rcarriga/nvim-dap-ui" })
	use({ "theHamsta/nvim-dap-virtual-text" })
	use({ "nvim-telescope/telescope-dap.nvim" })
	use({ "mfussenegger/nvim-dap-python" })
	use({ "leoluz/nvim-dap-go" })

	-- UI
	use({ "goolord/alpha-nvim" })
	use({ "nvim-neo-tree/neo-tree.nvim", requires = { "MunifTanjim/nui.nvim" } })
	-- use({ "kyazdani42/nvim-tree.lua" })
	use({ "akinsho/bufferline.nvim" })
	use({ "nvim-lualine/lualine.nvim" })
	use({ "akinsho/toggleterm.nvim" })
	use({ "rcarriga/nvim-notify" })

	use({ "ahmedkhalf/project.nvim" })
	use({ "b0o/schemastore.nvim" })

	-- shortcut plugins
	use({ "folke/which-key.nvim", commit = "" })

	-- Colorschemes
	use({ "LunarVim/onedarker.nvim" })
	use({ "EdenEast/nightfox.nvim" })
	use({ "glepnir/zephyr-nvim" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim" })

	-- Git
	use({ "lewis6991/gitsigns.nvim" })
	use({ "akinsho/git-conflict.nvim", tag = "*" })
	use({ "https://gitlab.com/yorickpeterse/nvim-pqf", as = "monokai-pro.nvim" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
