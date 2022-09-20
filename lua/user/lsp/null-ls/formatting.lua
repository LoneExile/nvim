-- M = {}

local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	vim.notify("null_ls" .. " not found!")
	return
end
local formatting = null_ls.builtins.formatting

local format = {
  	formatting.prettier.with({
		filetypes = {
			"javascript",
			"typescript",
			"typescriptreact",
			"javascriptreact",
			"json",
			"yaml",
			"markdown",
			"html",
			"css",
			"scss",
			"lua",
		},
		disabled_filetypes = { "lua", "python" },
		extra_filetypes = { "toml" },
	}),

	formatting.stylua.with({
		filetypes = { "lua" },
		extra_args = { "--column-width", "120" },
	}),

	formatting.black.with({
		filetypes = { "python" },
		extra_args = { "--fast", "--line-length", "90" },
	}),

	formatting.beautysh.with({
		filetypes = { "bash", "csh", "ksh", "sh", "zsh" },
		extra_args = { "$FILENAME", "--indent", "4" },
	}),

	-- formatting.shfmt.with({
	--   filetypes = { "bash", "csh", "ksh", "sh", "zsh" },
	--   extra_args = { "-i", "4", "-ci", "-sr", "-bn", "-kp", "-s", "-ln", "bash" },
	-- }),

	formatting.markdownlint.with({
		filetypes = { "markdown" },
		extra_args = { "--fix" },
	}),
}

-- return M
return format
