local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	vim.notify("null_ls" .. " not found!")
	return
end
local diagnostics = null_ls.builtins.diagnostics

local diagnostics = {
	-- diagnostics
	diagnostics.markdownlint.with({
		filetypes = { "markdown" },
	}),
	diagnostics.shellcheck.with({
		filetypes = { "bash", "csh", "ksh", "sh", "zsh" },
		extra_args = { "--severity", "warning" },
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
}

return diagnostics
