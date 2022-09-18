local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local colors = {
	dark = {
		"#619e9d",
		"#9E6162",
		"#81A35C",
		"#7E5CA3",
		"#9E9261",
		"#616D9E",
		"#97687B",
		"#689784",
		"#999C63",
		"#66639C",
		"#967869",
		"#698796",
		"#9E6189",
		"#619E76",
	},
	bright = { "#f5c0c0", "#f5d3c0", "#f5eac0", "#dff5c0", "#c0f5c8", "#c0f5f1", "#c0dbf5", "#ccc0f5", "#f2c0f5" },
	medium = {
		"#c99d9d",
		"#c9a99d",
		"#c9b79d",
		"#c9c39d",
		"#bdc99d",
		"#a9c99d",
		"#9dc9b6",
		"#9dc2c9",
		"#9da9c9",
		"#b29dc9",
		"#c99dc1",
	},
}

local queriess = {
	default = "(identifier) @markid",
	javascript = [[
          (identifier) @markid
          (property_identifier) @markid
          (shorthand_property_identifier_pattern) @markid
        ]],
}
queriess.typescript = queriess.javascript

local commentConfig = require("user.editor.treesitter.commentString").configs

configs.setup({
	ensure_installed = "all",
	sync_install = false,
	auto_install = true,
	ignore_install = { "" },
	highlight = {
		enable = true,
		disable = { "" },
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true, disable = { "python", "css" } },

	-- **nvim-ts-context-commentstring**
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		config = commentConfig,
	},

	-- **nvim-ts-rainbow**
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- termcolors = {} -- table of colour name strings
		colors = {
			-- "#68a0b0",
			-- "#946EaD",
			-- "#c7aA6D",
			"Gold",
			"Orchid",
			"DodgerBlue",
			-- "Cornsilk",
			-- "Salmon",
			-- "LawnGreen",
		},
		disable = { "html" },
	},

	-- ** markid ** better highlight
	markid = {
		enable = false,
		colors = colors.bright,
		queries = queriess,
		is_supported = function(lang)
			local queries = configs.get_module("markid").queries
			return pcall(vim.treesitter.parse_query, lang, queries[lang] or queries["default"])
		end,
	},
})
