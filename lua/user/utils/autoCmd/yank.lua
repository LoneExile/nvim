local api = vim.api

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
	-- command = "silent! lua vim.highlight.on_yank()",
	command = "silent! lua vim.highlight.on_yank({higroup = 'IncSearch',timeout = 40,})",
	group = yankGrp,
})
