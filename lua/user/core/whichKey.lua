local M = {}

local terminal = require("user.editor.coding.toggleterm").terminal
terminal.execs = {
	{ "lazygit", "<leader>gg", "LazyGit", "float" },
	{ "lazygit", "<leader>tg", "LazyGit", "float" },
	{
		"nnn -er",
		"<leader>tn",
		"nnn",
		"float",
	},
	{
		"htop",
		"<leader>th",
		"htop",
		"float",
	},
}

function M.setup()
	local status_ok, whichkey = pcall(require, "which-key")
	if not status_ok then
		vim.notify("which-key" .. " not found!")
		return
	end

	local conf = {
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			presets = {
				operators = false, -- adds help for operators like d, y, ...
				motions = false, -- adds help for motions
				text_objects = false, -- help for text objects triggered after entering an operator
				windows = false, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
			spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
		},
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 0,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
		show_help = true, -- show help message on the command line when the popup is visible
		triggers = "auto", -- automatically setup triggers
		-- triggers = {"<leader>"} -- or specify a list manually
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			-- this is mostly relevant for key maps that start with a native binding
			-- most people should not need to change this
			i = { "j", "k" },
			v = { "j", "k" },
		},
	}

	local opts = {
		mode = "n", -- Normal mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	local vopts = {
		mode = "v", -- VISUAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	local mappings = {
		["e"] = {
			-- "<cmd>NvimTreeToggle<CR>",
			"<cmd>NeoTreeFloatToggle<CR>",
			-- function()
			-- 	vim.cmd("NeoTreeFloatToggle")
			-- 	-- 	vim.cmd("Neotree position=float toggle=true")
			-- end,
			"Explorer",
		},
		[";"] = { "<cmd>Alpha<CR>", "Dashboard" },
		["w"] = { "<cmd>SaveNFormat<CR>", "Save" },
		["q"] = { "<cmd>lua require('user.utils.quit').smart_quit()<CR>", "Quit" },
		["/"] = {
			"<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
			"Comment",
		},
		["c"] = {
			require("user.ui.bufferline").buf_kill,
			"Close Buffer",
		},
		["f"] = {
			require("telescope.builtin").find_files,
			"Find File",
		},
		["H"] = {
			"<cmd>nohlsearch<CR>",
			"No Highlight",
		},
		t = { name = "terminal" },
		b = {
			name = "Buffers",
			p = {
				"<cmd>echo expand('%:p')<cr>",
				"Path",
			},
			j = {
				"<cmd>BufferLinePick<cr>",
				"Jump",
			},
			f = {
				"<cmd>Telescope buffers<cr>",
				"Find",
			},
			b = {
				"<cmd>BufferLineCyclePrev<cr>",
				"Previous",
			},
			-- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
			e = {
				"<cmd>BufferLinePickClose<cr>",
				"Pick which buffer to close",
			},
			h = {
				"<cmd>BufferLineCloseLeft<cr>",
				"Close all to the left",
			},
			l = {
				"<cmd>BufferLineCloseRight<cr>",
				"Close all to the right",
			},
			D = {
				"<cmd>BufferLineSortByDirectory<cr>",
				"Sort by directory",
			},
			L = {
				"<cmd>BufferLineSortByExtension<cr>",
				"Sort by language",
			},
		},
		p = {
			name = "Packer",
			c = {
				"<cmd>PackerCompile<cr>",
				"Compile",
			},
			i = {
				"<cmd>PackerInstall<cr>",
				"Install",
			},
			s = { "<cmd>PackerSync<cr>", "Sync" },
			S = {
				"<cmd>PackerStatus<cr>",
				"Status",
			},
			u = {
				"<cmd>PackerUpdate<cr>",
				"Update",
			},
		},
		h = {
			name = "Harpoon",
			h = {
				"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
				"Harpoon",
			},
			s = {
				"<cmd>lua require('harpoon.mark').add_file()<cr>",
				"Add File",
			},
			a = {
				"<cmd>OpenHarpoonAll<cr>",
				"Open all",
			},
			k = {
				"<cmd>lua require('harpoon.ui').nav_prev()<cr>",
				"Previous",
			},
			j = { "<cmd>lua require('harpoon.ui').nav_next() <cr>", "Next" },
		},

		g = {
			name = "Git",
			j = {
				"<cmd>lua require 'gitsigns'.next_hunk()<cr>",
				"Next Hunk",
			},
			k = {
				"<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
				"Prev Hunk",
			},
			l = {
				"<cmd>lua require 'gitsigns'.blame_line()<cr>",
				"Blame",
			},
			p = {
				"<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
				"Preview Hunk",
			},
			r = {
				"<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
				"Reset Hunk",
			},
			R = {
				"<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
				"Reset Buffer",
			},
			s = {
				"<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
				"Stage Hunk",
			},
			u = {
				"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
				"Undo Stage Hunk",
			},
			o = {
				"<cmd>Telescope git_status<cr>",
				"Open changed file",
			},
			b = {
				"<cmd>Telescope git_branches<cr>",
				"Checkout branch",
			},
			c = {
				"<cmd>Telescope git_commits<cr>",
				"Checkout commit",
			},
			C = {
				"<cmd>Telescope git_bcommits<cr>",
				"Checkout commit(for current file)",
			},
			d = {
				-- "<cmd>Gitsigns diffthis HEAD<cr>",
				name = "Git Diff",
				d = {
					"<cmd>DiffviewOpen<cr>",
					"Git Diff",
				},
				c = {
					"<cmd>DiffviewClose<cr>",
					"Diff Close",
				},
				f = {
					"<cmd>DiffviewToggleFiles<cr>",
					"Diff Toggle Files",
				},
				r = {
					"<cmd>DiffviewRefresh<cr>",
					"Diff Refresh",
				},
				h = {
					"<cmd>DiffviewFileHistory %<cr>",
					"History Current",
				},
				H = {
					"<cmd>DiffviewFileHistory<cr>",
					"Diff File History",
				},
			},
		},
		l = {
			name = "LSP",
			d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
			w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
			r = {
				"<cmd>Lspsaga lsp_finder<cr>",
				"References",
			},
			o = {
				"<cmd>LSoutlineToggle<cr>",
				"Outline",
			},
			f = {
				require("user.utils.format").format,
				"Format",
			},
			R = {
				"<cmd>Lspsaga rename<CR>",
				"Rename",
			},
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			q = { vim.diagnostic.setloclist, "Quickfix" },
			i = { "<cmd>LspInfo<cr>", "Info" },
			I = { "<cmd>Mason<cr>", "Mason Info" },
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
			S = {
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				"Workspace Symbols",
			},
			e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
			C = {
				name = "Codi",
				c = {
					"<cmd>Codi!!<cr>",
					"Codi Toggle",
				},
				e = {
					"<cmd>CodiExpand<cr>",
					"Expand",
				},
				s = {
					"<cmd>:CodiSelect<cr>",
					"Select",
				},
			},
			c = {
				name = "Sniprun",
				c = {
					"<cmd>lua require'sniprun'.run()<cr>",
					"Run",
				},
				r = {
					"<cmd>lua require'sniprun'.reset()<cr>",
					"Reset",
				},
				s = {
					"<cmd>lua require'sniprun.display'.close_all()<cr>",
					"Stop",
				},
				l = {
					"<cmd>lua require'sniprun.live_mode'.toggle()<cr>",
					"Live",
				},
				i = {
					"<cmd>lua require'sniprun'.info()<cr>",
					"Info",
				},
				m = {
					"<cmd>lua require'sniprun'.clear_repl()<cr>",
					"Memory Clear",
				},
			},
			-- s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
			-- S = {
			--   "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			--   "Workspace Symbols",
			-- },
			-- e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
		},
		s = {
			name = "Search",
			s = {
				"<cmd>lua require('spectre').open_file_search()<CR>",
				"Search in current file",
			},
			S = {
				"<cmd>lua require('spectre').open()<CR>",
				"Search in project",
			},
			b = {
				"<cmd>Telescope git_branches<cr>",
				"Checkout branch",
			},
			c = {
				"<cmd>Telescope colorscheme<cr>",
				"Colorscheme",
			},
			f = {
				"<cmd>Telescope find_files<cr>",
				"Find File",
			},
			h = {
				"<cmd>Telescope help_tags<cr>",
				"Find Help",
			},
			H = {
				"<cmd>Telescope highlights<cr>",
				"Find highlight groups",
			},
			M = {
				"<cmd>Telescope man_pages<cr>",
				"Man Pages",
			},
			r = {
				"<cmd>Telescope oldfiles<cr>",
				"Open Recent File",
			},
			R = {
				"<cmd>Telescope registers<cr>",
				"Registers",
			},
			t = {
				"<cmd>Telescope live_grep<cr>",
				"Text",
			},
			k = {
				"<cmd>Telescope keymaps<cr>",
				"Keymaps",
			},
			C = {
				"<cmd>Telescope commands<cr>",
				"Commands",
			},
			p = {
				"<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
				"Colorscheme with Preview",
			},
		},
		u = {
			name = "+Utility",
			n = {
				name = "+Neotree",
				b = { "<cmd>Neotree action=focus source=buffers position=float toggle=true<CR>", "Buffer" },
				g = { "<cmd>Neotree action=focus source=git_status position=float toggle=true<CR>", "Git" },
				r = { "<cmd>Neotree action=focus source=filesystem position=right toggle=true<CR>", "Show tree right" },
			},
			s = {
				name = "+Session",
				l = { "<cmd>SessionManager load_last_session<cr>", "Load last session" },
				s = { "<cmd>SessionManager save_current_session<cr>", "Save session" },
				d = { "<cmd>SessionManager delete_session<cr>", "Delete session" },
				L = { "<cmd>SessionManager load_session<cr>", "Load session" },
				c = { "<cmd>SessionManager load_current_dir_session<cr>", "Load current dir" },
			},
			c = {
				name = "+Color picker",
				p = {
					"<cmd>Colortils picker<cr>",
					"picker",
				},
				l = {
					"<cmd>Colortils lighten<cr>",
					"lighten",
				},
				d = {
					"<cmd>Colortils darken<cr>",
					"darken",
				},
				s = {
					"<cmd>Colortils greyscale<cr>",
					"greyscale",
				},
				g = {
					"<cmd>Colortils gradient<cr>",
					"gradient",
				},
				L = { "<cmd>Colortils css list<cr>", "List" },
			},
		},
		d = {
			name = "Debug",
			t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
			b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
			c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
			C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
			d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
			g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
			i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
			o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
			u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
			p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
			r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
			s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
			q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
		},
	}

	local vmappings = {
		l = {
			name = "LSP",
			c = { name = "SnipRun", c = { "<cmd>lua require'sniprun'.run('v')<cr>", "Run" } },
		},
		g = {
			name = "Git",
			d = {
				name = "Blame",
				d = { "<cmd>DiffviewFileHistory<cr>", "History this line" },
			},
		},
	}
	vmappings["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" }
	whichkey.setup(conf)
	whichkey.register(mappings, opts)
	whichkey.register(vmappings, vopts)
end

return M
