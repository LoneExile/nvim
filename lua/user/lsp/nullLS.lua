local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	vim.notify("null_ls" .. " not found!")
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local hover = null_ls.builtins.hover
-- local completion = null_ls.builtins.completion

local sources = {
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

	-- diagnostics
	diagnostics.markdownlint.with({
		filetypes = { "markdown" },
	}),
	diagnostics.flake8.with({
		filetypes = { "python" },
		extra_args = { "--max-line-length", "90" },
	}),
	diagnostics.shellcheck.with({
		extra_args = { "--severity", "warning" },
	}),
	diagnostics.eslint.with({
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
		},
		extra_args = {
			-- "-f",
			-- "json",
			-- "--stdin",
			-- "--stdin-filename",
			-- "$FILENAME",
			"--no-eslintrc",
			"--env",
			"es6",
		},
	}),
	diagnostics.zsh.with({
		filetypes = { "zsh" },
		extra_args = { "-n", "$FILENAME" },
	}),

	diagnostics.actionlint.with({
		filetype = { "yaml" },
		extra_args = { "-no-color", "-format", "{{json .}}", "-" },
	}),

	-- code_actions
	code_actions.gitsigns.with({
		disabled_filetypes = { "lua" },
	}),
	code_actions.refactoring.with({
		filetype = { "go", "javascript", "lua", "python", "typescript" },
	}),
	code_actions.eslint.with({
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
		},
		extra_args = {
			-- "-f",
			-- "json",
			-- "--stdin",
			-- "--stdin-filename",
			-- "$FILENAME",
			"--no-eslintrc",
			"--env",
			"es6",
		},
	}),
	code_actions.shellcheck.with({
		extra_args = { "--severity", "warning" },
	}),

	-- hover
	hover.dictionary.with({
		filetypes = { "text", "markdown" },
	}),
	hover.printenv.with({
		filetypes = { "bash", "csh", "ksh", "sh", "zsh" },
	}),
}

null_ls.setup({ sources = sources })
